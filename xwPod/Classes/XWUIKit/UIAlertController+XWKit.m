//
//  UIAlertController+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/25.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import "UIAlertController+XWKit.h"

#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

@implementation UIAlertController (XWKit)

/** 单个按键的 弹窗 */
+ (void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void(^)(void))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // creat action
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (handler) {
            handler();
        }
    }];
    
    // add acton
    [alert addAction:confirmAction];
    
    // present alertView on rootViewController
    [kRootViewController presentViewController:alert animated:YES completion:nil];
}

/** 双按键的 弹窗 */
+ (void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle alertType:(XWAlertActionType)alertType leftHandle:(void(^)(void))leftHandle rightHandle:(void(^)(void))rightHandle{
    
    switch (alertType) {
        case XWAlertActionTypeLeftCancelAndRightDefatult:
            [self presentAlertViewWithTitle:title message:message leftTitle:leftTitle   leftAlertType:UIAlertActionStyleCancel rightTitle:rightTitle  rightAlertType:UIAlertActionStyleDefault leftHandle:leftHandle rightHandle:rightHandle];
            break;
        case XWAlertActionTypeLeftDefatultAndRightCancel:
            [self presentAlertViewWithTitle:title message:message leftTitle:leftTitle   leftAlertType:UIAlertActionStyleDefault rightTitle:rightTitle  rightAlertType:UIAlertActionStyleCancel leftHandle:leftHandle rightHandle:rightHandle];
            break;
        case XWAlertActionTypeBothCancel:
            [self presentAlertViewWithTitle:title message:message leftTitle:leftTitle   leftAlertType:UIAlertActionStyleCancel rightTitle:rightTitle  rightAlertType:UIAlertActionStyleCancel leftHandle:leftHandle rightHandle:rightHandle];
            break;
        case XWAlertActionTypeBothDefatult:
            [self presentAlertViewWithTitle:title message:message leftTitle:leftTitle   leftAlertType:UIAlertActionStyleDefault rightTitle:rightTitle  rightAlertType:UIAlertActionStyleDefault leftHandle:leftHandle rightHandle:rightHandle];
            break;
        default:
            break;
    }
 
}

//通用模块
+(void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle leftAlertType:(UIAlertActionStyle)leftAlertType rightTitle:(NSString *)rightTitle rightAlertType:(UIAlertActionStyle)rightAlertType leftHandle:(void(^)(void))leftHandle rightHandle:(void(^)(void))rightHandle{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftTitle style:leftAlertType handler:^(UIAlertAction * _Nonnull action) {
        if (leftHandle) {
            leftHandle();
        }
    }];
    [alert addAction:leftAction];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightTitle style:rightAlertType handler:^(UIAlertAction * _Nonnull action) {
        if (leftHandle) {
            leftHandle();
        }
    }];
    [alert addAction:rightAction];

    [kRootViewController presentViewController:alert animated:YES completion:nil];
}

/** 多按键的双样式 弹窗 */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(0, @"取消");
    }];
    [alert addAction:cancelAction];
    
    for (int i = 0; i < actionTitles.count; i ++) {
        
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler((i + 1), actionTitles[i]);
        }];
        [alert addAction:confimAction];
    }
    
    [kRootViewController presentViewController:alert animated:YES completion:nil];
}
@end
