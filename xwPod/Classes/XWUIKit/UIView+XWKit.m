//
//  UIView+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/1/3.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIView+XWKit.h"
#import <objc/runtime.h>

//交换方法
CG_INLINE BOOL
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    if (!newMethod) {
        // class 里不存在该方法的实现
        return NO;
    }
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}


@interface UIView ()
///
@property(nonatomic, strong, readwrite) CAShapeLayer *xwborderLayer;

@end


@implementation UIView (XWKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(initWithFrame:), @selector(xw_initWithFrame:));
        ReplaceMethod([self class], @selector(initWithCoder:), @selector(xw_initWithCoder:));
        ReplaceMethod([self class], @selector(layoutSublayersOfLayer:), @selector(xw_layoutSublayersOfLayer:));
    });
}

- (instancetype)xw_initWithFrame:(CGRect)frame {
    [self xw_initWithFrame:frame];
    [self setDefaultStyle];
    return self;
}

- (instancetype)xw_initWithCoder:(NSCoder *)aDecoder {
    [self xw_initWithCoder:aDecoder];
    [self setDefaultStyle];
    return self;
}

- (void)setDefaultStyle {
    self.xwBorderWidth = [self pixelOne];
    self.xwBoderColor  =  [UIColor colorWithRed:222/255 green:224/255 blue:226/255 alpha:1];
}

//1像素
static CGFloat pixelOne = -1.0f;
-(CGFloat)pixelOne {
    if (pixelOne < 0) {
        pixelOne = 1 / [[UIScreen mainScreen] scale];
    }
    return pixelOne;
}
- (void)xw_layoutSublayersOfLayer:(CALayer *)layer {
    
    [self xw_layoutSublayersOfLayer:layer];
    
    if ((!self.xwborderLayer && self.xwBorderPosition == XWBorderViewPositionNone) || (!self.xwborderLayer && self.xwBorderWidth == 0)) {
        return;
    }
    
    if (self.xwborderLayer && self.xwBorderPosition == XWBorderViewPositionNone && !self.xwborderLayer.path) {
        return;
    }
    
    if (self.xwborderLayer && self.xwBorderWidth == 0 && self.xwborderLayer.lineWidth == 0) {
        return;
    }
    
    if (!self.xwborderLayer) {
        self.xwborderLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.xwborderLayer];
    }
    self.xwborderLayer.frame = self.bounds;
    CGFloat borderWidth = self.xwBorderWidth;
    self.xwborderLayer.lineWidth = borderWidth;
    self.xwborderLayer.strokeColor = self.xwBoderColor.CGColor;
    
    UIBezierPath *path = nil;
    if (self.xwBorderPosition != XWBorderViewPositionNone) {
        path = [UIBezierPath bezierPath];
    }
    
    if (self.xwBorderPosition & XWBorderViewPositionTop) {
        [path moveToPoint:CGPointMake(0, borderWidth / 2)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), borderWidth / 2)];
    }
    
    if (self.xwBorderPosition & XWBorderViewPositionLeft) {
        [path moveToPoint:CGPointMake(borderWidth / 2, 0)];
        [path addLineToPoint:CGPointMake(borderWidth / 2, CGRectGetHeight(self.bounds) - 0)];
    }
    
    if (self.xwBorderPosition & XWBorderViewPositionBottom) {
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds) - borderWidth / 2)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - borderWidth / 2)];
    }
    
    if (self.xwBorderPosition & XWBorderViewPositionRignt) {
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) - borderWidth / 2, 0)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - borderWidth / 2, CGRectGetHeight(self.bounds))];
    }
    
    if (self.xwBorderPosition & XWBorderViewPositionBoth) {
        [path moveToPoint:CGPointMake(0, borderWidth / 2)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), borderWidth / 2)];
        [path moveToPoint:CGPointMake(borderWidth / 2, 0)];
        [path addLineToPoint:CGPointMake(borderWidth / 2, CGRectGetHeight(self.bounds) - 0)];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.bounds) - borderWidth / 2)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - borderWidth / 2)];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) - borderWidth / 2, 0)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - borderWidth / 2, CGRectGetHeight(self.bounds))];
    }
    self.xwborderLayer.path = path.CGPath;
}



static char kAssociatedObjectKey_borderPosition;
-(void)setXwBorderPosition:(XWBorderViewPosition)xwBorderPosition{
    
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderPosition, @(xwBorderPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}
-(XWBorderViewPosition)xwBorderPosition{
    return (XWBorderViewPosition)[objc_getAssociatedObject(self, &kAssociatedObjectKey_borderPosition) unsignedIntegerValue];

}

static char kAssociatedObjectKey_borderWidth;
-(void)setXwBorderWidth:(CGFloat)xwBorderWidth{
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderWidth, @(xwBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}
-(CGFloat)xwBorderWidth{
    return (CGFloat)[objc_getAssociatedObject(self, &kAssociatedObjectKey_borderWidth) floatValue];
}


static char kAssociatedObjectKey_borderColor;
-(void)setXwBoderColor:(UIColor *)xwBoderColor{
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderColor, xwBoderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}
-(UIColor *)xwBoderColor{
    return (UIColor *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderColor);
}


static char kAssociatedObjectKey_borderLayer;
-(void)setXwborderLayer:(CAShapeLayer *)xwborderLayer{
    
    objc_setAssociatedObject(self, &kAssociatedObjectKey_borderLayer, xwborderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CAShapeLayer *)xwborderLayer{
    return (CAShapeLayer *)objc_getAssociatedObject(self, &kAssociatedObjectKey_borderLayer);

}

-(void)creatBorderPosition:(XWBorderViewPosition)borderPosition withBorderWidth:(CGFloat)borderWidth withBorderColor:(UIColor *)borderColor{
    
    self.xwBorderPosition = borderPosition;
    self.xwBorderWidth = borderWidth;
    self.xwBoderColor = borderColor;
    
}

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (void)removeAllSubViews{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/* *< 设置圆角 */
- (void)setupCornerRadius:(float)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

// 阴影+圆角 设置了masksToBounds属性为YES了，将后面设置的阴影效果给裁剪掉了，所以我们看不到阴影效果，如果我们将masksToBounds属性为NO了，这样就会失去圆角效果（尽管会出现阴影效果）.给imageView添加一个父视图，在父视图上添加阴影效果就好，这样就不会对imageView的圆角造成影响了。clipsToBounds:视图上的子视图,如果超出父视图的部分就截取掉, masksToBounds:视图的图层上的子图层,如果超出父图层的部分就截取掉
- (void)setupShadowRadius:(float)radius andCornerRadius:(float)cornerRadius {
    
    UIView *shadowView = [[UIView alloc]initWithFrame:self.frame];
    [self addSubview:shadowView];
    shadowView.layer.cornerRadius = cornerRadius; //设置圆角
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor; // 设置阴影的颜色
    shadowView.layer.shadowOffset = CGSizeMake(5, 5); //设置阴影的偏移量
    shadowView.layer.shadowOpacity = 1; //设置阴影的透明度
    shadowView.layer.shadowRadius = radius; //设置阴影的圆角
    [shadowView addSubview:self];
}

// 分割线
+ (void)setupCellLineTo:(UIView *)view frame:(CGRect)frame Color:(UIColor *)color{
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    [view addSubview:line];
    
}
@end
