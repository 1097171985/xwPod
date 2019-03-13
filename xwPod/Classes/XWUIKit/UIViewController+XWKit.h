//
//  UIViewController+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/1/3.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+XWKit.h"

@interface UIViewController (XWKit)

// 获取和自身处于同一个UINavigationController里的上一个UIViewConttroller
@property(nullable,nonatomic,weak,readonly)UIViewController *previousViewController;

// 获取上个UIViewController的title
@property(nullable,nonatomic,copy,readonly)NSString *previousViewControllerTitle;

/*
  UINavigationBar 在 self.view 坐标系里的 maxY，一般用于 self.view.subviews 布局时参考用
  @warning 注意由于使用了坐标系转换的计算，所以要求在 self.view.window 存在的情况下使用才可以，因此请勿在 viewDidLoad 内使用，建议在 viewDidLayoutSubviews、viewWillAppear: 里使用。
  @warning 如果不存在 UINavigationBar，则返回 0
 */
@property(nonatomic,assign,readonly)CGFloat navigationBarMaxY;

/*
   底部 UITabBar 在 self.view 坐标系里的占位高度，一般用于 self.view.subviews 布局时参考用
   @warning 注意由于使用了坐标系转换的计算，所以要求在 self.view.window 存在的情况下使用才可以，因此请勿在 viewDidLoad 内使用，建议在 viewDidLayoutSubviews、viewWillAppear: 里使用。
   @warning 如果不存在 UITabBar，则返回 0
 */
@property(nonatomic,assign,readonly)CGFloat tabBarSpacingHeight;


/*
   底部 UIToolbar 在 self.view 坐标系里的占位高度，一般用于 self.view.subviews 布局时参考用
   @warning 注意由于使用了坐标系转换的计算，所以要求在 self.view.window 存在的情况下使用才可以，因此请勿在 viewDidLoad 内使用，建议在 viewDidLayoutSubviews、viewWillAppear: 里使用。
   @warning 如果不存在 UIToolbar，则返回 0
 */
@property(nonatomic, assign, readonly) CGFloat toolbarSpacingHeight;

// 获取当前控制器的最高可见viewController，可能为nil
-(nullable UIViewController *)visibleViewControllerIfExist;

//获取当前应用的最高可见viewController,可能为nil
+(nullable UIViewController *)visibleViewController;

//是否是被present的方式显示
-(BOOL)isPresented;

//是否应该响应一些UI相关的通知，例如 UIKeyboardNotification、UIMenuControllerNotification等，因为有可能当前界面已经被切走了（push到其他界面），但仍可能收到通知，所以在响应通知之前都应该做一下这个判断
-(BOOL)isViewLoadedAndVisible;


@end
