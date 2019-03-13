//
//  UIDevice+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/15.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import "UIDevice+XWKit.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (XWKit)

+ (NSString * _Nonnull)devicePlatform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

- (NSString * _Nonnull)devicePlatform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}


+ (NSString * _Nonnull)devicePlatformString {
    NSString *platform = [self devicePlatform];
    // iPhone
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // iPod
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    // iPad
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (China)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    // iPad mini
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad mini 2 (China)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad mini 4 (Cellular)";
    // iPad Pro 9.7
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7 (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7 (Cellular)";
    // iPad Pro 12.9
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9 (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9 (Cellular)";
    // Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3G";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3G";
    if ([platform isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4G";
    // Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])     return @"Apple Watch 38mm";
    if ([platform isEqualToString:@"Watch1,2"])     return @"Apple Watch 42mm";
    // Simulator
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

+ (BOOL)isSimulator {
    if ([[self devicePlatform] isEqualToString:@"i386"] || [[self devicePlatform] isEqualToString:@"x86_64"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isRetina {
    return [self isUIScreenRetina];
}

+ (BOOL)isRetinaHD {
    return [self isUIScreenRetinaHD];
}

+ (NSInteger)iOSVersion {
    return [[[UIDevice currentDevice] systemVersion] integerValue];
}

+ (NSUInteger)getSysInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}


+ (BOOL)isUIScreenRetina {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0)) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isUIScreenRetinaHD {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 3.0)) {
        return YES;
    } else {
        return NO;
    }
}

- (CGSize)sizeInPixel {
    CGSize size = CGSizeZero;
    
    if ([[UIScreen mainScreen] isEqual:self]) {
        NSString *model = [self devicePlatform];
        if ([model hasPrefix:@"iPhone"]) {
            if ([model isEqualToString:@"iPhone7,1"]) return CGSizeMake(1080, 1920);
            if ([model isEqualToString:@"iPhone8,2"]) return CGSizeMake(1080, 1920);
            if ([model isEqualToString:@"iPhone9,2"]) return CGSizeMake(1080, 1920);
            if ([model isEqualToString:@"iPhone9,4"]) return CGSizeMake(1080, 1920);
        }
        if ([model hasPrefix:@"iPad"]) {
            if ([model hasPrefix:@"iPad6,7"]) size = CGSizeMake(2048, 2732);
            if ([model hasPrefix:@"iPad6,8"]) size = CGSizeMake(2048, 2732);
        }
    }
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        if ([self respondsToSelector:@selector(nativeBounds)]) {
            size = [UIScreen mainScreen].nativeBounds.size;
        } else {
            size = [UIScreen mainScreen].bounds.size;
            size.width *= [UIScreen mainScreen].scale;
            size.height *= [UIScreen mainScreen].scale;
        }
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    }
    return size;
}

- (CGFloat)pixelsPerInch {
    if (![[UIScreen mainScreen] isEqual:self]) {
        return 326;
    }
    
    static CGFloat ppi = 0;
    static dispatch_once_t one;
    dispatch_once(&one, ^{
        NSDictionary<NSString*, NSNumber *> *dic = @{
                                                     @"Watch1,1" : @326, //@"Apple Watch 38mm",
                                                     @"Watch1,2" : @326, //@"Apple Watch 43mm",
                                                     @"Watch2,3" : @326, //@"Apple Watch Series 2 38mm",
                                                     @"Watch2,4" : @326, //@"Apple Watch Series 2 42mm",
                                                     @"Watch2,6" : @326, //@"Apple Watch Series 1 38mm",
                                                     @"Watch2,7" : @326, //@"Apple Watch Series 1 42mm",
                                                     
                                                     @"iPod1,1" : @163, //@"iPod touch 1",
                                                     @"iPod2,1" : @163, //@"iPod touch 2",
                                                     @"iPod3,1" : @163, //@"iPod touch 3",
                                                     @"iPod4,1" : @326, //@"iPod touch 4",
                                                     @"iPod5,1" : @326, //@"iPod touch 5",
                                                     @"iPod7,1" : @326, //@"iPod touch 6",
                                                     
                                                     @"iPhone1,1" : @163, //@"iPhone 1G",
                                                     @"iPhone1,2" : @163, //@"iPhone 3G",
                                                     @"iPhone2,1" : @163, //@"iPhone 3GS",
                                                     @"iPhone3,1" : @326, //@"iPhone 4 (GSM)",
                                                     @"iPhone3,2" : @326, //@"iPhone 4",
                                                     @"iPhone3,3" : @326, //@"iPhone 4 (CDMA)",
                                                     @"iPhone4,1" : @326, //@"iPhone 4S",
                                                     @"iPhone5,1" : @326, //@"iPhone 5",
                                                     @"iPhone5,2" : @326, //@"iPhone 5",
                                                     @"iPhone5,3" : @326, //@"iPhone 5c",
                                                     @"iPhone5,4" : @326, //@"iPhone 5c",
                                                     @"iPhone6,1" : @326, //@"iPhone 5s",
                                                     @"iPhone6,2" : @326, //@"iPhone 5s",
                                                     @"iPhone7,1" : @401, //@"iPhone 6 Plus",
                                                     @"iPhone7,2" : @326, //@"iPhone 6",
                                                     @"iPhone8,1" : @326, //@"iPhone 6s",
                                                     @"iPhone8,2" : @401, //@"iPhone 6s Plus",
                                                     @"iPhone8,4" : @326, //@"iPhone SE",
                                                     @"iPhone9,1" : @326, //@"iPhone 7",
                                                     @"iPhone9,2" : @401, //@"iPhone 7 Plus",
                                                     @"iPhone9,3" : @326, //@"iPhone 7",
                                                     @"iPhone9,4" : @401, //@"iPhone 7 Plus",
                                                     
                                                     @"iPad1,1" : @132, //@"iPad 1",
                                                     @"iPad2,1" : @132, //@"iPad 2 (WiFi)",
                                                     @"iPad2,2" : @132, //@"iPad 2 (GSM)",
                                                     @"iPad2,3" : @132, //@"iPad 2 (CDMA)",
                                                     @"iPad2,4" : @132, //@"iPad 2",
                                                     @"iPad2,5" : @264, //@"iPad mini 1",
                                                     @"iPad2,6" : @264, //@"iPad mini 1",
                                                     @"iPad2,7" : @264, //@"iPad mini 1",
                                                     @"iPad3,1" : @324, //@"iPad 3 (WiFi)",
                                                     @"iPad3,2" : @324, //@"iPad 3 (4G)",
                                                     @"iPad3,3" : @324, //@"iPad 3 (4G)",
                                                     @"iPad3,4" : @324, //@"iPad 4",
                                                     @"iPad3,5" : @324, //@"iPad 4",
                                                     @"iPad3,6" : @324, //@"iPad 4",
                                                     @"iPad4,1" : @324, //@"iPad Air",
                                                     @"iPad4,2" : @324, //@"iPad Air",
                                                     @"iPad4,3" : @324, //@"iPad Air",
                                                     @"iPad4,4" : @264, //@"iPad mini 2",
                                                     @"iPad4,5" : @264, //@"iPad mini 2",
                                                     @"iPad4,6" : @264, //@"iPad mini 2",
                                                     @"iPad4,7" : @264, //@"iPad mini 3",
                                                     @"iPad4,8" : @264, //@"iPad mini 3",
                                                     @"iPad4,9" : @264, //@"iPad mini 3",
                                                     @"iPad5,1" : @264, //@"iPad mini 4",
                                                     @"iPad5,2" : @264, //@"iPad mini 4",
                                                     @"iPad5,3" : @324, //@"iPad Air 2",
                                                     @"iPad5,4" : @324, //@"iPad Air 2",
                                                     @"iPad6,3" : @324, //@"iPad Pro (9.7 inch)",
                                                     @"iPad6,4" : @324, //@"iPad Pro (9.7 inch)",
                                                     @"iPad6,7" : @264, //@"iPad Pro (12.9 inch)",
                                                     @"iPad6,8" : @264, //@"iPad Pro (12.9 inch)",
                                                     };
        NSString *model = [self devicePlatform];
        if (model) {
            ppi = dic[model].doubleValue;
        }
        if (ppi == 0) ppi = 326;
    });
    return ppi;
}



+ (NSString * _Nonnull)appBuildVersion {

    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}


@end
