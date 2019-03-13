//
//  UIDevice+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/15.
//  Copyright © 2017年 xinwang2. All rights reserved.
//  设备信息

#import <UIKit/UIKit.h>

/**
 *  Macros that returns if the iOS version is greater or equal to choosed one
 *  系统版本至少超过几
 *  @return Returns a BOOL
 */
#define IS_IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_IOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_IOS_11_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IS_IOS_12_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)


/**
 *Macros that returns if the iOS version is greater or equal to choosed one
 *系统大小 屏幕宽度，屏幕高度 ，宽比 ，高比，以及安全区域
 @return Returns
 */
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]
#define Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define Width(R)  (R)*(Screen_Width)/375    //这里的375我是针对6为标准适配的,如果需要其他标准可以修改
#define Height(R) (R)*(Screen_Height)/667   //这里的667我是针对6为标准适配的,如果需要其他标准可以修改
#define Font(R)   (R)*(Screen_Width)/375    //这里是6屏幕字体

#define Device_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define Device_Is_iPhoneSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136),[[UIScreen mainScreen] currentMode].size) : NO) //640 x 1136  se 5s
#define Device_Is_iPhone ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1134),[[UIScreen mainScreen] currentMode].size) : NO) //750 x 1134    6,7,8
#define Device_Is_iPhoneP ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080,1920),[[UIScreen mainScreen] currentMode].size) : NO) //1080 x 1920  6p,7p,8p

#define StatusBarHeight (Device_iPhoneX ? 44 : 20)
#define SafeAreaTopHeight (Device_iPhoneX ? 88 : 64)
#define SafeAreaBottomHeight (Device_iPhoneX ? 34 : 0)

#define EnglishKeyboardHeight  (216.f)
#define ChineseKeyboardHeight  (252.f)
#define NvcBarHeight           (44.f)
#define TabBarHeight           (49.f)

// kewWindow
#define KeyWindow [UIApplication sharedApplication].keyWindow
//** 沙盒路径 ***********************************************************************************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//document沙河路径
#define SHABOXDOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//Caches沙河路径
#define SHABOXCACHES [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface UIDevice (XWKit)

/**
 返回屏幕的像素（这个值在一个未知的设备或模拟器中可能不是很精确）
 */
@property (nonatomic, readonly) CGSize sizeInPixel;

/**
  返回屏幕的ppi(这个值在一个未知的设备或模拟器中可能不是很精确。默认96)
 */
@property (nonatomic, readonly) CGFloat pixelsPerInch;

/**
 设备型号

 @return Returns the device platform string
 */
+ (NSString * _Nonnull)devicePlatform;

/**
 设备名称

 @return Returns the user-friendly device platform string
 */
+ (NSString * _Nonnull)devicePlatformString;

/**
 是否是模拟器

 @return  Returns YES if it's the simulator, NO if not
 */
+ (BOOL)isSimulator;

/**
 是否横屏
 */
+ (BOOL)isRetina DEPRECATED_MSG_ATTRIBUTE("Use +isRetina in UIScreen class");

/**
 是否RetinaHD
 */
+ (BOOL)isRetinaHD DEPRECATED_MSG_ATTRIBUTE("Use +isRetinaHD in UIScreen class");

/**
 iOS 版本号

 @return <#return value description#>
 */
+ (NSInteger)iOSVersion;

/**
 内部版本号

 @return 内部版本号
 */
+ (NSString * _Nonnull)appBuildVersion;

@end
