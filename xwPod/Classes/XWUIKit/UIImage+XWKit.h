//
//  UIImage+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/8.
//  Copyright © 2017年 xinwang2. All rights reserved.
// UIImage 所需分类部分，暂时提供这几个接口

#import <UIKit/UIKit.h>


@interface UIImage (XWKit)

/**
  颜色转换成图片

 @param color color
 @return return UIImage
 */
+(UIImage *_Nonnull)imageWithColor:(UIColor *_Nonnull)color;

/**
 颜色转换指定大小的图片

 @param color color
 @param size size
 @return return UIImage
 */
+ (UIImage *_Nonnull)imageWithColor:(UIColor *_Nonnull)color andSize:(CGSize)size;

/**
 将图片裁剪成圆形图片
 @return return UIImage
 */
- (UIImage *_Nonnull)roundImage;

/**
 截屏，截图操作

 @param view view
 @return return UIImage
 */
+ (UIImage *_Nonnull)cutFromView:(UIView *_Nonnull)view;

/**
 创建一个表情图片

 @param emoji 表情
 @param size 大小
 @return 图片
 */
+ (UIImage *_Nonnull)imageWithEmoji:(NSString *_Nonnull)emoji size:(CGFloat)size;

/**
 将pdf转换为图片

 @param dataOrPath 路径
 @return 将pdf转换为图片
 */
+ (UIImage *_Nonnull)imageWithPDF:(id _Nonnull)dataOrPath;

/**
 将pdf转换为图片

 @param dataOrPath 路径
 @param size 大小
 @return 图片
 */
+ (UIImage *_Nonnull)imageWithPDF:(id _Nonnull)dataOrPath size:(CGSize)size;
/**
 更换图片的颜色

 @param image image
 @param targetColor targetColor description
 @param mode mode
 @return 返回新图片
 */
- (UIImage *_Nonnull)changImageColorWithImage:(UIImage *_Nonnull)image  color:(UIColor *_Nonnull)targetColor blendModel:(CGBlendMode)mode;

/**
 *  获得主要颜色
 *
 *  @return 返回主要颜色
 */
- (UIColor *_Nonnull)mostColor;

/**
 图片是否有透明通道

 @return yes or no
 */
- (BOOL)hasAlphaChannel;


- (UIImage * _Nonnull)imageByScalingProportionallyToSize:(CGSize)targetSize;

/**
  加载bundle里面的图片资源

 @param imageName 图片名称
 @param bundle bundle名称
 @param targetClass 所在类
 @return 图片
 */

+ (instancetype _Nonnull )ff_imagePathWithName:(NSString *_Nonnull)imageName bundle:(NSString *_Nonnull)bundle targetClass:(Class _Nonnull )targetClass;

/** 建议使用 xw_imageNamed:atClass: */
//+ (UIImage *_Nullable)imageNamed:(NSString *_Nonnull)name __attribute__((deprecated("请使用 xw_imageNamed: atClass:")));

/**
 加载bundle的图片资源

 @param name 图片名称
 @param classs 资源所在的类代表 (self.class)
 @return image
 */
+ (nullable UIImage *)xw_imageNamed:(NSString *_Nonnull)name atClass:(Class _Nonnull)classs;



+ (instancetype _Nonnull )imagePathWithName:(NSString *)imageName bundle:(NSString *)bundle targetClass:(Class)targetClass;

@end
