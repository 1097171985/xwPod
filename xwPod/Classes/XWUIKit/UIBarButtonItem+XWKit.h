//
//  UIBarButtonItem+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/7.
//  Copyright © 2017年 xinwang2. All rights reserved.
//  创建 UIBarButtonItem

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XWKit)

@property (nonatomic,copy) void(^actionBlock)(id  sender);

/**
 创建空隙的 UIBarButtonItem

 @param spaceType spaceType
 @param width width
 @return return UIBarButtonItem
 */
- (instancetype)initWithBarbuttonSpaceType:(UIBarButtonSystemItem) spaceType width:(CGFloat)width;

//仅文字
- (instancetype)initWithCustomTextViewFrame:(CGRect)frame  textSize:(UIFont *)textSize  textColor:(UIColor *)textColor withText:(NSString *)text;

//文字,图片一起
- (instancetype)initWithCustomTextViewFrame:(CGRect)frame  textSize:(UIFont *)textSize  textColor:(UIColor *)textColor withText:(NSString *)text withImage:(NSString *)imageStr;

//MARK:以下可能是业务需求写法
- (instancetype)initWithImage:(NSString *)image target:(id)target action:(SEL)action; /**< UIBarButtonItem分类 */

- (instancetype)initWithtextColor:(UIColor *)textColor Text:(NSString *)text target:(id)target action:(SEL)action;

@end
