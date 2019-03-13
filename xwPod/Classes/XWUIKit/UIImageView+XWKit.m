//
//  UIImageView+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/3/1.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIImageView+XWKit.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIImageView (XWKit)

+ (instancetype)initWithImage:(UIImage *)image frame:(CGRect)rect{
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setFrame:rect];
    [imageView setImage:image];
    return imageView;
}

+ (instancetype)initWithImage:(UIImage *)image size:(CGSize)size center:(CGPoint)center{
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    [imageView setCenter:center];
    return imageView;
}

+ (instancetype)initWithImage:(UIImage *)image center:(CGPoint)center{
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [imageView setImage:image];
    [imageView setCenter:center];
    return imageView;
}

+ (instancetype)initWithImageAsTemplate:(UIImage *)image tintColor:(UIColor *)tintColor{
    UIImageView *imageView = [[UIImageView alloc]init];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imageView setImage:image];
    [imageView setTintColor:tintColor];
    return imageView;
}

- (void)setImageShadowColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity{
    self.layer.shadowColor   = color.CGColor;
    self.layer.shadowRadius  = radius;
    self.layer.shadowOffset  = offset;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}

- (void)setMaskImage:(UIImage *)image{
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[image CGImage];
    mask.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.layer.mask = mask;
    self.layer.masksToBounds = YES;
}

// 加载bundle的图片资源
- (instancetype)initWithImageName:(NSString *)name atClass:(Class)classs {
    self = [super init];
    if (self) {
        
        NSBundle *currentBundle = [NSBundle bundleForClass:classs];
        NSString *currentBundleName = [currentBundle objectForInfoDictionaryKey: (NSString*)kCFBundleExecutableKey];
        NSURL *bundleURL = [currentBundle URLForResource:currentBundleName withExtension:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
        UIImage *img = [UIImage imageNamed:name inBundle:resourceBundle compatibleWithTraitCollection:nil];
       
        /*
        NSBundle *currentBundle = [NSBundle bundleForClass:classs];
        UIImage *img = [UIImage imageNamed:name inBundle:currentBundle compatibleWithTraitCollection:nil];
        */
        
        self.image = img;
    }
    return self;
}

@end
