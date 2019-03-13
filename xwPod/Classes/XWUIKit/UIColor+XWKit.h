//
//  UIColor+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/19.
//  Copyright © 2017年 xinwang2. All rights reserved.
//  颜色  16进制

#import <UIKit/UIKit.h>

#define XWRGBA(Red,Green,Blue,Alpha) [UIColor colorWithWholeRed:Red green:Green blue:Blue alpha:Alpha]
#define XWRGB(Red,Green,Blue) [UIColor colorWithWholeRed:Red green:Green blue:Blue]
#define Hex(hexString) [UIColor colorWithHexString:hexString]


@interface UIColor (XWKit)



/**
 *  由16进制颜色字符串格式生成UIColor
 *
 *  @param hexString 16进制颜色#00FF00
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
  red,green,blue,alpa

 @param red red
 @param green green
 @param blue blue descriptionblue
 @param alpha alpha
 @return return UIColor
 */
+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;

/**
 red,green,blue

 @param red red
 @param green green
 @param blue blue
 @return return UIColor
 */
+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;


/**
 生成当前颜色的16进制字符串
 
 @return 生成当前颜色的16进制字符串
 */
- (NSString *)HEXString;

/**
 生产随机颜色

 @return  生产随机颜色
 */
+ (UIColor *)RandomColor;

/**
 返回图片某点的颜色

 @param image 图片
 @param point 点坐标
 @return 生产颜色
 */
+ (UIColor *)colorForm:(UIImage *)image AtPoint:(CGPoint)point;

/**
 *  获得颜色RGB值
 *
 *  @param color 颜色
 *
 *  @return 返回颜色RGB值
 */
- (NSArray *)RGBComponentsWithColor:(UIColor *)color;

/**
 生产一个新的颜色

 @param addColor 原色
 @param blendMode blendMode
 @return color
 */
- (UIColor *)colorByAddColor:(UIColor *)addColor blendMode:(CGBlendMode)blendMode;

@end
