//
//  UIAlertController+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/25.
//  Copyright © 2017年 xinwang2. All rights reserved.
//  系统弹窗的封装

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,XWAlertActionType) {
    XWAlertActionTypeLeftCancelAndRightDefatult,   //左侧取消样式 右侧默认样式
    XWAlertActionTypeLeftDefatultAndRightCancel, // 左侧默认样式 右侧取消样式
    XWAlertActionTypeBothCancel,    //  都是取消样式
    XWAlertActionTypeBothDefatult,    // 都是默认样式
    
};


@interface UIAlertController (XWKit)


/**
 单个按键的弹窗

 @param title 标题
 @param message 内容信息
 @param confirmTitle 按键标题
 @param handler 返回事件
 */
+(void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void(^)(void))handler;



/**
 双按键的弹窗
 默认左侧取消样式
 @param title 标题
 @param message 内容信息
 @param leftTitle 左标题
 @param rightTitle 右标题
 @param alertType 警告类型
 @param leftHandle 左按键回调
 @param rightHandle 右按键回调
 */
+ (void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle alertType:(XWAlertActionType)alertType leftHandle:(void(^)(void))leftHandle rightHandle:(void(^)(void))rightHandle;


/**
 任意多按键的任意样式的弹窗

 @param title 标题
 @param message  内容信息
 @param actionTitles 按键标题数组
 @param preferredStyle 弹窗类型 alertView or ActionSheet
 @param handler  按键回调
 */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler;
@end
