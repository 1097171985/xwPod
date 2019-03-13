//
//  UIImageView+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/3/1.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XWKit)

/**
 创建UIimageView视图

 @param image 图片资源
 @param rect 视图大小
 @return 返回 UIimageview
 */
+ (instancetype)initWithImage:(UIImage *)image frame:(CGRect)rect;

/**
 创建UIimageview视图

 @param image 图片资源
 @param size  视图大小
 @param center 中心点
 @return 返回UIimageview
 */
+ (instancetype)initWithImage:(UIImage *)image size:(CGSize)size center:(CGPoint)center;

/**
 创建UIimageview视图

 @param image 图片资源
 @param center 中心点
 @return 返回UIimageview
 */
+ (instancetype)initWithImage:(UIImage *)image center:(CGPoint)center;

/**
 创建UIimageview视图

 @param image 图片资源
 @param tintColor tintColor
 @return 返回UIimageview
 */
+ (instancetype)initWithImageAsTemplate:(UIImage *)image tintColor:(UIColor *)tintColor;

/**
 创建视图阴影

 @param color   Shadow's color
 @param radius  Shadow's radius
 @param offset  Shadow's offset
 @param opacity Shadow's opacity
 */
- (void)setImageShadowColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity;

/**
 创建一个图片遮罩

 @param image 图片资源
 */
- (void)setMaskImage:(UIImage *)image;

/**
 加载bundle的图片资源
 
 @param name 图片名称
 @param classs 资源所在的类代表 (self.class)
 @return UIImageView
 */
- (instancetype)initWithImageName:(NSString *)name atClass:(Class)classs;

@end
