//
//  UIViewController+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/1/3.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIViewController+XWKit.h"
#import "UINavigationController+XWKit.h"
/// 判断一个 CGRect 是否存在NaN
CG_INLINE BOOL
CGRectIsNaN(CGRect rect) {
    return isnan(rect.origin.x) || isnan(rect.origin.y) || isnan(rect.size.width) || isnan(rect.size.height);
}

/// 系统提供的 CGRectIsInfinite 接口只能判断 CGRectInfinite 的情况，而该接口可以用于判断 INFINITY 的值
CG_INLINE BOOL
CGRectIsInf(CGRect rect) {
    return isinf(rect.origin.x) || isinf(rect.origin.y) || isinf(rect.size.width) || isinf(rect.size.height);
}


CG_INLINE BOOL
CGRectIsValidated(CGRect rect) {
    return !CGRectIsNull(rect) && !CGRectIsInfinite(rect) && !CGRectIsNaN(rect) && !CGRectIsInf(rect);
}

@implementation UIViewController (XWKit)


-(UIViewController *)previousViewController{
    
    if (self.navigationController.viewControllers && self.navigationController.viewControllers.count >1 && self.navigationController.topViewController == self) {
        
        NSUInteger count = self.navigationController.viewControllers.count;
        return (UIViewController *)[self.navigationController.viewControllers objectAtIndex:count-2];
    }
    
    return nil;
}

-(NSString *)previousViewControllerTitle{
    
    UIViewController *previousViewController = [self previousViewController];
    if (previousViewController) {
        
        return previousViewController.title;
    }
    return nil;
}


-(CGFloat)navigationBarMaxY{
    
    if (!self.isViewLoaded) {
        return 0;
    }
    if (!self.navigationController.navigationBar || self.navigationController.navigationBarHidden) {
        return 0;
    }
    CGRect navigatioBarFrameInView = [self.view convertRect:self.navigationController.navigationBar.frame fromView:self.navigationController.navigationBar.superview];
    
    CGRect navigationBarFrame = CGRectIntersection(self.view.bounds, navigatioBarFrameInView);
      // 两个 rect 如果不存在交集，CGRectIntersection 计算结果可能为非法的 rect，所以这里做个保护
    if (CGRectIsValidated(navigationBarFrame)) {
        
        return 0;
    }
    CGFloat result = CGRectGetMaxY(navigationBarFrame);
    return result;
}


-(CGFloat)tabBarSpacingHeight{
    if (!self.isViewLoaded) {
        return 0;
    }
    if (!self.tabBarController.tabBar || self.tabBarController.tabBar.hidden) {
        return 0;
    }
    CGRect tabBarFrame = CGRectIntersection(self.view.bounds, [self.view convertRect:self.tabBarController.tabBar.frame fromView:self.tabBarController.tabBar.superview]);
    
    // 两个 rect 如果不存在交集，CGRectIntersection 计算结果可能为非法的 rect，所以这里做个保护
    if (!CGRectIsValidated(tabBarFrame)) {
        return 0;
    }
    
    CGFloat result = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(tabBarFrame);
    return result;
    
}

-(CGFloat)toolbarSpacingHeight{
    if (!self.isViewLoaded) {
        return 0;
    }
    if (!self.navigationController.toolbar || self.navigationController.toolbarHidden) {
        return 0;
    }
    CGRect toolbarFrame = CGRectIntersection(self.view.bounds, [self.view convertRect:self.navigationController.toolbar.frame fromView:self.navigationController.toolbar.superview]);
    
    // 两个 rect 如果不存在交集，CGRectIntersection 计算结果可能为非法的 rect，所以这里做个保护
    if (!CGRectIsValidated(toolbarFrame)) {
        return 0;
    }
    
    CGFloat result = CGRectGetHeight(self.view.bounds) - CGRectGetMinY(toolbarFrame);
    return result;
}


-(UIViewController *)visibleViewControllerIfExist{
    
    if (self.presentedViewController) {
        return [self.presentedViewController visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)self).visibleViewController visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return [((UITabBarController *)self).selectedViewController visibleViewControllerIfExist];
    }
    
    if ([self isViewLoaded] && self.view.window) {
        return self;
    } else {
        NSLog(@"qmui_visibleViewControllerIfExist:，找不到可见的viewController。self = %@, self.view = %@, self.view.window = %@", self, [self isViewLoaded] ? self.view : nil, [self isViewLoaded] ? self.view.window : nil);
        return nil;
    }
    
}

+ (nullable UIViewController *)visibleViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *visibleViewController = [rootViewController visibleViewControllerIfExist];
    return visibleViewController;
}



-(BOOL)isPresented{
    UIViewController *viewController = self;
    if (self.navigationController) {
        if (self.navigationController.rootViewController != self) {
            return NO;
        }
        viewController = self.navigationController;
    }
    BOOL result = viewController.presentingViewController.presentedViewController == viewController;
    return result;
}

-(BOOL)isViewLoadedAndVisible{
    
    return self.isViewLoaded && self.view.window;
}





@end
