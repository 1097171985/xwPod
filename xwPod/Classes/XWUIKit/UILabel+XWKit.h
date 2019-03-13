//
//  UILabel+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/8.
//  Copyright © 2017年 xinwang2. All rights reserved.
//  创建 UILabel

#import <UIKit/UIKit.h>

@interface UILabel (XWKit)

/**
 创建 UILabel

 @param text text description
 @param font <#font description#>
 @param color <#color description#>
 @param alignment <#alignment description#>
 @param lines <#lines description#>
 @return <#return value description#>
 */
- (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines Text:(NSString *)text ;


/**
 创建 UILabel
 
 @param text text description
 @param font font description
 @param color <#color description#>
 @param alignment <#alignment description#>
 @param lines <#lines description#>
 @return <#return value description#>
 */
+ (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines Text:(NSString *)text ;

/**
 创建 UILabel

 @param text <#text description#>
 @param font <#font description#>
 @param color <#color description#>
 @param alignment <#alignment description#>
 @param lines <#lines description#>
 @param shadowColor <#shadowColor description#>
 @return <#return value description#>
 */
- (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)shadowColor Text:(NSString *)text;


/**
 创建 UILabel
 
 @param text <#text description#>
 @param font <#font description#>
 @param color <#color description#>
 @param alignment <#alignment description#>
 @param lines <#lines description#>
 @param shadowColor <#shadowColor description#>
 @return <#return value description#>
 */
+ (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)shadowColor Text:(NSString *)text;

/**
 创建 简单富文本UILabel （只封装了颜色和字体）
 注意事项：数组的位置必须一一对应

 @param text 总的字符串
 @param font 总的字体大小
 @param color 总的字体颜色
 @param subStringArray 需要改变的字符串数组
 @param colorArray 需要改变的字符串的颜色数组
 @param fontArray 需要改变的字符串的字体数组
 @return <#return value description#>
 */
-(instancetype)initWithFont:(UIFont *)font color:(UIColor *)color SubStringArray:(NSArray *)subStringArray SubColorArray:(NSArray<UIColor *> *)colorArray  SubFontArray:(NSArray<UIFont *>*)fontArray Text:(NSString *)text ;


/**
 创建 简单富文本UILabel （只封装了颜色和字体）
 注意事项：数组的位置必须一一对应
 
 @param text 总的字符串
 @param font 总的字体大小
 @param color 总的字体颜色
 @param subStringArray 需要改变的字符串数组
 @param colorArray 需要改变的字符串的颜色数组
 @param fontArray 需要改变的字符串的字体数组
 @return <#return value description#>
 */
+ (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color SubStringArray:(NSArray *)subStringArray SubColorArray:(NSArray<UIColor *> *)colorArray  SubFontArray:(NSArray<UIFont *>*)fontArray Text:(NSString *)text ;
@end
