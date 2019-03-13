//
//  UIButton+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/6.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import "UIButton+XWKit.h"
#import <objc/runtime.h>
#import "XWUIKitCommonDefines.h"
@implementation UIButton (XWKit)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

/**初始化**/
- (instancetype)initWithMainBackGrundColor:(UIColor *)mainColor font:(CGFloat)font Title:(NSString *)title {
    return [self initWithTitleColor:[UIColor whiteColor] backGroundColor:mainColor font:font backgroundImage:nil highlightedBackgroundImage:nil Title:title];
}

/**
 创建 UIButton 类方法
 
 @param mainColor mainColor
 @param font font
 @param title title
 @return UIButton
 */
+ (instancetype)initWithMainBackGrundColor:(UIColor *)mainColor font:(CGFloat)font Title:(NSString *)title{
    return [self initWithTitleColor:mainColor backGroundColor:[UIColor whiteColor] font:font backgroundImage:nil highlightedBackgroundImage:nil Title:title];
}

- (instancetype)initWithMainTextColor:(UIColor *)mainColor font:(CGFloat)font Title:(NSString *)title {
    return [self initWithTitleColor:mainColor backGroundColor:[UIColor whiteColor] font:font backgroundImage:nil highlightedBackgroundImage:nil Title:title];
}

+ (instancetype)initWithMainTextColor:(UIColor *)mainColor font:(CGFloat)font Title:(NSString *)title {
    return [self initWithTitleColor:mainColor backGroundColor:[UIColor whiteColor] font:font backgroundImage:nil highlightedBackgroundImage:nil Title:title];
}

- (instancetype)initWithTitleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor font:(CGFloat)font backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage Title:(NSString *)title {
    
    self = [super init];
    if (self) {
        self = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleLabel setFont:[UIFont systemFontOfSize:font]];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
        [self setBackgroundColor:backGroundColor];
    }
    
    return self;
}

+ (instancetype)initWithTitleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor font:(CGFloat)font backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage Title:(NSString *)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setFont:[UIFont systemFontOfSize:font]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    [button setBackgroundColor:backGroundColor];
    
    return button;
}


- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    return button;
}

+ (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    return button;
}



/**扩大点击区域***/
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

// 重复点击
// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)x_acceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setX_acceptEventInterval:(NSTimeInterval)x_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(x_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSTimeInterval)x_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setX_acceptEventTime:(NSTimeInterval)x_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(x_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 在load时执行hook
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ReplaceMethod([self class], @selector(sendAction:to:forEvent:), @selector(x_sendAction:to:forEvent:));
        
        ReplaceMethod([self class], @selector(pointInside:withEvent:), @selector(x_pointInside:withEvent:));
    });
}


- (BOOL)x_pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}


- (void)x_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    // 方式一
    if ([NSDate date].timeIntervalSince1970 - self.x_acceptEventTime < self.x_acceptEventInterval) {
        return;
    }
    if (self.x_acceptEventInterval > 0) {
        self.x_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    [self x_sendAction:action to:target forEvent:event];
    
}

@end
