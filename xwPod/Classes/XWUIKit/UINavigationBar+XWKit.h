//
//  UINavigationBar+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/3/1.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (XWKit)

/**
 设置透明度

 @param transparent transparent description
 */
- (void)setTransparent:(BOOL)transparent;

/**
 设置透明度

 @param transparent   YES to set it transparent, NO to not
 @param translucent  A Boolean value indicating whether the navigation bar is translucent or not
 */
- (void)setTransparent:(BOOL)transparent translucent:(BOOL)translucent;
@end
