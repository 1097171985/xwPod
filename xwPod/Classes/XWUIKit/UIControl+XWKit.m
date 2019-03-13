//
//  UIControl+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/8.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIControl+XWKit.h"
#import <objc/runtime.h>
#import "XWUIKitCommonDefines.h"

static const void *XWBlockKey = &XWBlockKey;
static const int block_key;
static char  XWAutomaticallyAdjustTouchKey;
static char  XWSetHighlightedKey;
static char  XWCanSetHighlightedKey;
static char  XWTouchEndCountKey;
static char  XWOutsideEdgeKey;

@interface XWUIControlBlockTarget : NSObject

@property (nonatomic,copy) void (^block)(id sender);

@property (nonatomic,assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;

- (void)invoke:(id)sender;

@end

@implementation XWUIControlBlockTarget

- (id)initWithBlock:(void (^)(id))block events:(UIControlEvents)events{
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender{
    if (_block)  _block(sender);
}
@end


@implementation UIControl (XWKit)

- (void)setAutomaticallyAdjustTouchHightedInScrollView:(BOOL)automaticallyAdjustTouchHightedInScrollView{
   objc_setAssociatedObject(self, &XWAutomaticallyAdjustTouchKey, [NSNumber numberWithBool:automaticallyAdjustTouchHightedInScrollView], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (BOOL)automaticallyAdjustTouchHightedInScrollView{
    NSNumber *boolAuto = objc_getAssociatedObject(self, &XWAutomaticallyAdjustTouchKey);
    return [boolAuto boolValue];
}

- (void)setOutsideEdge:(UIEdgeInsets)outsideEdge{
    objc_setAssociatedObject(self, &XWOutsideEdgeKey, [NSValue valueWithUIEdgeInsets:outsideEdge], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)outsideEdge{
    NSValue *outValue = objc_getAssociatedObject(self, &XWOutsideEdgeKey);
    return [outValue UIEdgeInsetsValue];
}

- (void)setXWsetHighlightBlcok:(void (^)(BOOL))XWsetHighlightBlcok{
    objc_setAssociatedObject(self, &XWsetHighlightBlcok, XWsetHighlightBlcok, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(BOOL))XWsetHighlightBlcok{
    return objc_getAssociatedObject(self, &XWSetHighlightedKey);
}

- (void)setBlock:(void (^)(id))Block{
    
    objc_setAssociatedObject(self, XWBlockKey, Block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addBlockForControlEvents:UIControlEventTouchUpInside block:Block];
}

-(void (^)(id))Block{
    return objc_getAssociatedObject(self, XWBlockKey);
}

- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction) forControlEvents:controlEvents];
        }
    }
    [self addTarget:self action:action forControlEvents:controlEvents];
}

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void(^)(id sender))block{
    if(!controlEvents) return;
    XWUIControlBlockTarget *target = [[XWUIControlBlockTarget alloc]initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self allUIControlBlockTargets];
    [targets addObject:target];
}

- (void)setTouchEndCount:(NSInteger)touchEndCount {
    objc_setAssociatedObject(self, &XWTouchEndCountKey, @(touchEndCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)touchEndCount {
    return [objc_getAssociatedObject(self, &XWTouchEndCountKey) integerValue];
}

- (void)setCanSetHighlighted:(BOOL)canSetHighlighted {
    objc_setAssociatedObject(self, &XWCanSetHighlightedKey, [NSNumber numberWithBool:canSetHighlighted], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canSetHighlighted {
    return (BOOL)[objc_getAssociatedObject(self, &XWCanSetHighlightedKey) boolValue];
}

- (void)setBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    [self removeAllBlocksForControlEvents:UIControlEventAllEvents];
    [self addBlockForControlEvents:controlEvents block:block];
}

- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    for (XWUIControlBlockTarget *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}

- (NSMutableArray *)allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}


+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clz = [self class];
        SEL beginSelector = @selector(touchesBegan:withEvent:);
        SEL swizzled_beginSelector = @selector(xw_touchesBegan:withEvent:);
        
        SEL moveSelector = @selector(touchesMoved:withEvent:);
        SEL swizzled_moveSelector = @selector(xw_touchesMoved:withEvent:);
        
        SEL endSelector = @selector(touchesEnded:withEvent:);
        SEL swizzled_endSelector = @selector(xw_touchesEnded:withEvent:);
        
        SEL cancelSelector = @selector(touchesCancelled:withEvent:);
        SEL swizzled_cancelSelector = @selector(xw_touchesCancelled:withEvent:);
        
        SEL pointInsideSelector = @selector(pointInside:withEvent:);
        SEL swizzled_pointInsideSelector = @selector(xw_pointInside:withEvent:);
        
        SEL setHighlightedSelector = @selector(setHighlighted:);
        SEL swizzled_setHighlightedSelector = @selector(xw_setHighlighted:);
        
        ReplaceMethod(clz, beginSelector, swizzled_beginSelector);
        ReplaceMethod(clz, moveSelector, swizzled_moveSelector);
        ReplaceMethod(clz, endSelector, swizzled_endSelector);
        ReplaceMethod(clz, cancelSelector, swizzled_cancelSelector);
        ReplaceMethod(clz, pointInsideSelector, swizzled_pointInsideSelector);
        ReplaceMethod(clz, setHighlightedSelector, swizzled_setHighlightedSelector);
        
    });
    
}

- (void)xw_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.touchEndCount = 0;
    if (self.automaticallyAdjustTouchHightedInScrollView) {
        self.canSetHighlighted = YES;
        [self xw_touchesBegan:touches withEvent:event];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.canSetHighlighted) {
                [self setHighlighted:YES];
            }
        });
    }else{
        [self xw_touchesBegan:touches withEvent:event];
    }
}

- (void)xw_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.automaticallyAdjustTouchHightedInScrollView) {
        self.canSetHighlighted = NO;
        [self xw_touchesMoved:touches withEvent:event];
    }else{
        [self xw_touchesMoved:touches withEvent:event];
    }
}

- (void)xw_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.automaticallyAdjustTouchHightedInScrollView) {
        self.canSetHighlighted = NO;
        if (self.touchInside) {
            [self setHighlighted:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self sendActionsForAllTouchEventsIfCan];
                if (self.highlighted) {
                    [self setHighlighted:NO];
                }
            });
        }else{
            [self setHighlighted:NO];
        }
    }else{
        [self xw_touchesEnded:touches withEvent:event];
    }
}


- (void)xw_touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.automaticallyAdjustTouchHightedInScrollView) {
        self.canSetHighlighted = NO;
        [self xw_touchesCancelled:touches withEvent:event];
        if (self.highlighted) {
            [self setHighlighted:NO];
        }
    }else{
        [self xw_touchesCancelled:touches withEvent:event];
    }
}

- (BOOL)xw_pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if ([event type] != UIEventTypeTouches) {
        return [self xw_pointInside:point withEvent:event];
    }
    UIEdgeInsets xw_outsideEdge = self.outsideEdge;
    CGRect boudsInsetOutsideEdge = CGRectMake(CGRectGetMinX(self.bounds)+xw_outsideEdge.left, CGRectGetMinY(self.bounds)+xw_outsideEdge.top,CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(xw_outsideEdge), CGRectGetHeight(self.bounds) - UIEdgeInsetsGetVerticalValue(xw_outsideEdge));
    return CGRectContainsPoint(boudsInsetOutsideEdge, point);
}


- (void)xw_setHighlighted:(BOOL)highlighted{
    if (self.XWsetHighlightBlcok) {
        self.XWsetHighlightBlcok(highlighted);
    }
}
// 这段代码需要以一个独立的方法存在，因为一旦有坑，外面可以直接通过runtime调用这个方法
// 但，不要开放到.h文件里，理论上外面不应该用到它
- (void)sendActionsForAllTouchEventsIfCan {
    self.touchEndCount += 1;
    if (self.touchEndCount == 1) {
        [self sendActionsForControlEvents:UIControlEventAllTouchEvents];
    }
}











@end
