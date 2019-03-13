//
//  UIFont+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/26.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIFont+XWKit.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>

#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])

@implementation UIFont (XWKit)

+ (UIFont *)xw_lightSystemFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:IOS_VERSION >= 9.0 ? @".SFUIText-Light" : @"HelveticaNeue-Light" size:fontSize];
}

+ (UIFont *)xw_systemFontOfSize:(CGFloat)size weight:(XWUIFontWeight)weight italic:(BOOL)italic{
    BOOL isLight = weight == Light;
    BOOL isBold  = weight == Bold;
    BOOL shouldUsingHardCode = IOS_VERSION < 10.0;//这 UIfontDescriptor 也是醉人，相同代码只有 iOS 10 能得出正确结果，7-9都无法获取到 Light + Italic 的字体，只能写死。
    if(shouldUsingHardCode){
        NSString *name =  IOS_VERSION < 9.0 ? @"HelveticaNeue" : @".SFUIText";
        NSString *fontSuffix = [NSString stringWithFormat:@"%@%@",isLight ? @"Light" : (isBold ? @"Bold" : @""),italic ? @"Italic" : @""];
        NSString *fontName = [NSString stringWithFormat:@"%@%@%@",name,fontSuffix.length > 0 ? @"-" : @"",fontSuffix];
        UIFont   *font  = [UIFont fontWithName:fontName size:size];
        return font;
    }
    
    //ios10 以上使用的常规写法
    UIFont *font = nil;
    if ([self.class respondsToSelector:@selector(systemFontOfSize:weight:)]) {
        font = [UIFont systemFontOfSize:size weight:isLight ? UIFontWeightLight : (isBold ? UIFontWeightBold : UIFontWeightRegular)];
        //后面那些都是对斜体的操作，所以如果不需要斜体 就直接 return
        if (!italic) {
            return font;
        }
    }else{
        font = [UIFont systemFontOfSize:size];
    }
    
    UIFontDescriptor *fontDescriptor = font.fontDescriptor;
    NSMutableDictionary<NSString *,id> *traitsAttribute = [NSMutableDictionary dictionaryWithDictionary:fontDescriptor.fontAttributes[UIFontDescriptorTraitsAttribute]];
    if (![UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
        traitsAttribute[UIFontWeightTrait] = isLight ? @-1.0 : (isBold ? @1.0 : @0.0);
    }
    if (italic) {
        traitsAttribute[UIFontSlantTrait] = @1.0;
    }else{
        traitsAttribute[UIFontSlantTrait] = @0.0;
    }
    fontDescriptor = [fontDescriptor fontDescriptorByAddingAttributes:@{UIFontDescriptorTraitsAttribute:traitsAttribute}];
    font = [UIFont fontWithDescriptor:fontDescriptor size:0];
    return font;
}

+ (UIFont *)xw_dynamicSystemFontOfSize:(CGFloat)size weight:(XWUIFontWeight)weight italic:(BOOL)italic{
    return [self xw_dynamicSystemFontOfSize:size upperLimitSize:size + 5 lowerLimtSize:0 weight:weight italic:italic];
}


+ (UIFont *)xw_dynamicSystemFontOfSize:(CGFloat)pointSize upperLimitSize:(CGFloat)upperLimetSize lowerLimtSize:(CGFloat)lowerLimtSize weight:(XWUIFontWeight)weight italic:(BOOL)italic{
    
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    CGFloat offsetPointSize = font.pointSize - 17;//default UIFontTextStyleBody fontSize is 17
    CGFloat finalPointSize = pointSize + offsetPointSize;
    finalPointSize = MAX(MIN(finalPointSize, upperLimetSize), lowerLimtSize);
    font = [UIFont xw_dynamicSystemFontOfSize:finalPointSize weight:weight italic:NO];
    return font;
}

+ (BOOL)loadFontFromPath:(NSString *)path{
    NSURL *url = [NSURL fileURLWithPath:path];
    CFErrorRef error;
    BOOL suc = CTFontManagerRegisterFontsForURL((__bridge CFTypeRef)url, kCTFontManagerScopeNone, &error);
    if (!suc) {
        NSLog(@"Failed to load font: %@", error);
    }
    return suc;
    
}

+ (void)unloadFontFromPath:(NSString *)path{
    NSURL *url = [NSURL fileURLWithPath:path];
    CTFontManagerUnregisterFontsForURL((__bridge CFTypeRef)url, kCTFontManagerScopeNone, NULL);
}

+ (UIFont *)loadFontFromData:(NSData *)data{
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    if (!provider) return nil;
    CGFontRef fontRef = CGFontCreateWithDataProvider(provider);
    CGDataProviderRelease(provider);
    if (!fontRef)  return nil;
    
    CFErrorRef errorRef;
    BOOL suc = CTFontManagerRegisterGraphicsFont(fontRef, &errorRef);
    if (!suc) {
        CFRelease(fontRef);
        NSLog(@"%@",errorRef);
        return nil;
    }else{
        CFStringRef fontName = CGFontCopyPostScriptName(fontRef);
        UIFont *font = [UIFont fontWithName:(__bridge NSString *)(fontName) size:[UIFont systemFontSize]];
        if (fontName) CFRelease(fontName);
        CGFontRelease(fontRef);
        return font;
    }
}
@end
