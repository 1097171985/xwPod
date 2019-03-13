
//
//  UIToolbar+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/3/1.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIToolbar+XWKit.h"

@implementation UIToolbar (XWKit)

- (void)setTransparent:(BOOL)transparent{
    
    if (transparent) {
        [self setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    }else{
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self setShadowImage:nil forToolbarPosition:UIBarPositionAny];
    }
    
}

@end
