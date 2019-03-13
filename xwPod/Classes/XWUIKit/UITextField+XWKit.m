//
//  UITextField+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/8.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import "UITextField+XWKit.h"

@implementation UITextField (XWKit)

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType borderStyle:(UITextBorderStyle)borderStyle clearButtonMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setBorderStyle:borderStyle];
    [textField setClearButtonMode:clearButtonMode];
    [textField setKeyboardType:keyboardType];
    [textField setPlaceholder:placeholder];
    [textField setTextColor:color];
    [textField setReturnKeyType:returnType];
    [textField setFont:font];
    [textField setDelegate:delegate];
    
    return textField;
}

+ (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font returnType:(UIReturnKeyType)returnType keyboardType:(UIKeyboardType)keyboardType borderStyle:(UITextBorderStyle)borderStyle clearButtonMode:(UITextFieldViewMode)clearButtonMode delegate:(id<UITextFieldDelegate>)delegate{
    
    UITextField *textField = [[UITextField alloc]initWithFrame:frame placeholder:placeholder color:color font:font returnType:returnType keyboardType:keyboardType borderStyle:borderStyle clearButtonMode:clearButtonMode delegate:delegate];
                              
    return textField;
}


- (void)selectAllText{
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range{
    UITextPosition *beigin = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beigin offset:range.location];
    UITextPosition *endPosition   = [self positionFromPosition:beigin offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}
@end
