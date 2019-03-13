//
//  UITextField+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/8.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (XWKit)


/**
 创建 UITextField

 @param frame frame
 @param placeholder placeholder
 @param color color
 @param font font
 @param returnType returnType
 @param keyboardType keyboardType
 @param borderStyle borderStyle
 @param clearButtonMode clearButtonMode
 @param delegate delegate
 @return return UITextField
 */
- (instancetype)initWithFrame:(CGRect)frame
                           placeholder:(NSString *)placeholder
                                 color:(UIColor *)color
                                  font:(UIFont *)font
                            returnType:(UIReturnKeyType)returnType
                          keyboardType:(UIKeyboardType)keyboardType
                           borderStyle:(UITextBorderStyle)borderStyle
                       clearButtonMode:(UITextFieldViewMode)clearButtonMode
                              delegate:(id<UITextFieldDelegate>)delegate;



/**
 创建 UITextField
 
 @param frame frame
 @param placeholder placeholder
 @param color color
 @param font font
 @param returnType returnType
 @param keyboardType keyboardType
 @param borderStyle borderStyle
 @param clearButtonMode clearButtonMode
 @param delegate delegate
 @return return UITextField
 */
+ (instancetype)initWithFrame:(CGRect)frame
                  placeholder:(NSString *)placeholder
                        color:(UIColor *)color
                         font:(UIFont *)font
                   returnType:(UIReturnKeyType)returnType
                 keyboardType:(UIKeyboardType)keyboardType
                  borderStyle:(UITextBorderStyle)borderStyle
              clearButtonMode:(UITextFieldViewMode)clearButtonMode
                     delegate:(id<UITextFieldDelegate>)delegate;

/**
 选择所有的文字
 */
- (void)selectAllText;

/**
 选择一定区域的文字

 @param range range description
 */
- (void)setSelectedRange:(NSRange)range;
@end
