//
//  UITextView+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/12.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XWLimitLengthBlock)(NSInteger numLimit);

@interface UITextView (XWKit)

/**
 占位符
 */
@property (nonatomic,strong) NSString *placeholder;

/**
 字数限制
 */
@property (copy, nonatomic) NSNumber *limitLength;


/**
 占位符的位置
 */
@property(assign,nonatomic)CGRect  placeholderFrame;


/**
 Block 字数限制block返回事件
 */
@property(nonatomic, copy) XWLimitLengthBlock  limitBlock;
@end
