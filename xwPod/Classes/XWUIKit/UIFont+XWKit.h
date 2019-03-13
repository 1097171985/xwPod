//
//  UIFont+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/26.
//  Copyright © 2018年 xinwang2. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, XWUIFontWeight) {
    Light,
    Normal,
    Bold
};

@interface UIFont (XWKit)

/**
 返回系统字体的细体

 @param fontSize 字体大小
 @return 变细的系统字体的UIfont对象
 */
+ (UIFont *)xw_lightSystemFontOfSize:(CGFloat)fontSize;

/**
 根据需要生产一个 UIfont 对象并返回

 @param size 字体大小
 @param weight 字体粗细
 @param italic 是否斜体
 @return 返回一个UIfont对象
 */
+ (UIFont *)xw_systemFontOfSize:(CGFloat)size weight:(XWUIFontWeight)weight italic:(BOOL)italic;

/**
 *  根据需要生成一个支持响应动态字体大小调整的 UIFont 对象并返回
 *  @param  size    字号大小
 *  @param  weight  字重
 *  @param  italic  是否斜体
 *  @return         支持响应动态字体大小调整的 UIFont 对象
 */
+ (UIFont *)xw_dynamicSystemFontOfSize:(CGFloat)size
                                  weight:(XWUIFontWeight)weight
                                  italic:(BOOL)italic;

/**
 返回支持动态的字体的UIfont，支持定义最小和最大字号

 @param pointSize 默认的size
 @param upperLimetSize 最大的字号限制
 @param lowerLimtSize  最小的字号限制
 @param weight 字重
 @param italic 是否斜体
 @return 返回一个UIfont对象
 */
+ (UIFont *)xw_dynamicSystemFontOfSize:(CGFloat)pointSize upperLimitSize:(CGFloat)upperLimetSize lowerLimtSize:(CGFloat)lowerLimtSize  weight:(XWUIFontWeight)weight
                                italic:(BOOL)italic;

/**
 加载某一个自定义的字体库，如TTF,OTF.
 If return YES, font can be load use it PostScript Name: [UIFont fontWithName:...]
 @param path 路径
 @return 返回是否加载成功
 */
+ (BOOL)loadFontFromPath:(NSString *)path;

/**
 卸载某一个自定义的字体库，如TTF,OTF

 @param path 路径
 */
+ (void)unloadFontFromPath:(NSString *)path;

/**
 加载一个自定义字体

 @param data 数据
 @return 字体
 */
+ (UIFont *)loadFontFromData:(NSData *)data;
@end
