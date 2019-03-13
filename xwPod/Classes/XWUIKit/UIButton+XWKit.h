//
//  UIButton+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/6.
//  Copyright © 2017年 xinwang2. All rights reserved.
//  此分类主要来创建UIButton

#import <UIKit/UIKit.h>

typedef void(^XWButtonActionCallBack)(UIButton * _Nullable button);

@interface UIButton (XWKit)

@property (nonatomic, assign) NSTimeInterval x_acceptEventInterval; /**< 重复点击的间隔 */

@property (nonatomic, assign) NSTimeInterval x_acceptEventTime; // 暂存时间
/**
 创建 UIButton

 @param title title
 @param font font
 @param mainColor mainColor

 @return Returns the UIButton instance
 */
- (instancetype)initWithMainBackGrundColor:(UIColor *_Nullable)mainColor font:(CGFloat)font Title:(NSString * _Nullable)title;

/**
 创建 UIButton 类方法

 @param mainColor mainColor
 @param font font
 @param title title
 @return UIButton
 */
+ (instancetype)initWithMainBackGrundColor:(UIColor *)mainColor font:(CGFloat)font Title:(NSString *)title;
/**
 创建 UIButton

 @param title title
 @param font font
 @param mainColor mainColor

 @return Returns the UIButton instance
 */
- (instancetype)initWithMainTextColor:(UIColor *)mainColor font:(CGFloat)font Title:(NSString *)title;

/**
 创建 UIButton 类方法
 
 @param title title
 @param font font
 @param mainColor mainColor
 
 @return Returns the UIButton instance
 */
+ (instancetype)initWithMainTextColor:(UIColor *)mainColor font:(CGFloat)font Title:(NSString *)title;
/**
 创建 UIButton

 @param title title
 @param titleColor titleColor
 @param font font
 @param backgroundImage backgroundImage
 @return Returns the UIButton instance
 */
- (instancetype)initWithTitleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor font:(CGFloat)font backgroundImage:(UIImage * )backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage Title:(NSString *)title;

/**
 创建 UIButton 类方法
 
 @param title title
 @param titleColor titleColor
 @param font font
 @param backgroundImage backgroundImage
 @return Returns the UIButton instance
 */
+ (instancetype)initWithTitleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor font:(CGFloat)font backgroundImage:(UIImage * )backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage Title:(NSString *)title;

/**
 创建 UIButton

 @param image image
 @return Returns the UIButton instance
 */
- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

/**
 创建 UIButton 类方法
 
 @param image image
 @return Returns the UIButton instance
 */
+ (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

/**
 *  扩大 UIButton 的點擊範圍
 *  控制上下左右的延長範圍
 *
 *  @param top    <#top description#>
 *  @param right  <#right description#>
 *  @param bottom <#bottom description#>
 *  @param left   <#left description#>
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;


@end
