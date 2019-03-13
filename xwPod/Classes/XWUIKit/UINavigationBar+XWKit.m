//
//  UINavigationBar+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/3/1.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UINavigationBar+XWKit.h"

@implementation UINavigationBar (XWKit)

- (void)setTransparent:(BOOL)transparent{
    [self setTransparent:transparent translucent:YES];
}


- (void)setTransparent:(BOOL)transparent translucent:(BOOL)translucent{
    if (transparent) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        self.translucent = translucent;
    }else{
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = nil;
        self.translucent = translucent;
    }
}
@end
