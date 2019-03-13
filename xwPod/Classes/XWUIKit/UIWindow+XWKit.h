//
//  UIWindow+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/3/1.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (XWKit)

/**
 获取当前窗口的屏幕快照，但不保存图片。

 @return 屏幕快照
 */
- (UIImage *)takeScreenshot;

/**
 获取当前窗口的屏幕快照，是否保存图片

 @param save 是否保存图片
 @return 屏幕快照
 */
- (UIImage *)takeScreenshotAndSave:(BOOL)save;

/**
 获取当前窗口的屏幕截图，选择是否在延迟之后保存图片。

 @param delay 多少延迟
 @param save 是否保存
 @param completion 屏幕快照
 */
- (void)takeScreenshotWithDelay:(CGFloat)delay save:(BOOL)save completion:(void (^)(UIImage *screenshot))completion;

- (void)activateTouch;

- (void)deactivateTouch;

@end
