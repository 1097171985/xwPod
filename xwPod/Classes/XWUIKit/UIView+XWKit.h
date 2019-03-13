//
//  UIView+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/1/3.
//  Copyright © 2018年 xinwang2. All rights reserved.
//  主要设置边框，frame

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, XWBorderViewPosition){
    
    XWBorderViewPositionNone   = 0,
    XWBorderViewPositionTop    = 1 << 0,
    XWBorderViewPositionLeft   = 1 << 1,
    XWBorderViewPositionBottom = 1 << 2,
    XWBorderViewPositionRignt  = 1 << 3,
    XWBorderViewPositionBoth   = 1 << 4
};

@interface UIView (XWKit)
/**
 哪里有边框
 */
@property (nonatomic,assign) XWBorderViewPosition xwBorderPosition;
/**
 边框的长度,默认像素1
 */
@property (nonatomic,assign) CGFloat xwBorderWidth;
/**
 边框的颜色，默认颜色
 */
@property (nullable,nonatomic,strong) UIColor  *xwBoderColor;
/**
 获取当前视图的控制器
 */
@property (nullable,nonatomic,readonly)  UIViewController  *viewController;
/**
 设置边框

 @param borderPosition 边框在哪
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 */
- (void)creatBorderPosition:(XWBorderViewPosition)borderPosition withBorderWidth:(CGFloat)borderWidth withBorderColor:(UIColor *_Nullable)borderColor;
/**
 设置阴影
 
 @param color 阴影的颜色
 @param offset 阴影的偏移量
 @param radius 阴影的半径
 */
- (void)setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;
/**
 self 上的点 转换 为 相对于 view 的点 （view可以为nil,则表示该视图为window）

 @param point self 上的点
 @param view 相当于的视图
 @return 返回相对于view的点
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;
/**
 view 上的点 转换 为 相对于 self 的点 （view可以为nil,则表示该视图为window）

 @param point view 上的点
 @param view 被相对于的视图
 @return 返回 相对于self的点
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;
/**
 self 上的区域 转换 为 相对于 view 上的区域 （view可以为nil,则表示该视图为window）

 @param rect self 上的区域
 @param view 相对于的视图
 @return 返回相对于view的区域
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;
/**
 view 上的区域 转换 为 相对于 self 上的区域 （view可以为nil,则表示该视图为window）

 @param rect view上的区域
 @param view 被相对于的视图
 @return 返回相对于self的区域
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;
/**
 移除所有的子视图
 */
- (void)removeAllSubViews;


/**
 设置圆角

 @param radius 圆角
 */
- (void)setupCornerRadius:(float)radius; /* *< 设置圆角 */

/**
 设置圆角+阴影

 @param radius  阴影圆角
 @param cornerRadius 视图圆角
 */
- (void)setupShadowRadius:(float)radius andCornerRadius:(float)cornerRadius; /* *< 设置圆角+阴影 */

/**
 设置分割线

 @param superView 父视图
 @param frame 自身大小
 @param color 颜色
 */
+ (void)setupCellLineTo:(UIView *_Nonnull)superView frame:(CGRect)frame Color:(UIColor *_Nonnull)color; /* *< 分割线 */

@end
