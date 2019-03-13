//
//  UIBarButtonItem+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/7.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import "UIBarButtonItem+XWKit.h"
#import <objc/runtime.h>

static const int block_key;

@interface XWUIBarButtonItemBlockTarget : NSObject

@property (nonatomic,copy)  void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;

- (void)invoke:(id)sender;

@end

@implementation XWUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender{
    if (self.block) self.block(sender);
}

@end

@implementation UIBarButtonItem (XWKit)

- (instancetype)initWithBarbuttonSpaceType:(UIBarButtonSystemItem) spaceType width:(CGFloat)width{
    
    if (spaceType == UIBarButtonSystemItemFixedSpace || spaceType == UIBarButtonSystemItemFlexibleSpace) {
        
        self = [self initWithBarButtonSystemItem:spaceType target:nil action:nil];
        if (spaceType == UIBarButtonSystemItemFixedSpace) {
            self.width = width;
        }
    } else {
        self = [self initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    }
    return self;
}


- (void)setActionBlock:(void (^)(id))actionBlock{
    
    XWUIBarButtonItemBlockTarget *target = [[XWUIBarButtonItemBlockTarget alloc]initWithBlock:actionBlock];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTarget:self];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id))actionBlock{
    
    XWUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
    
}


- (instancetype)initWithCustomTextViewFrame:(CGRect)frame  textSize:(UIFont *)textSize  textColor:(UIColor *)textColor withText:(NSString *)text{
    
    UILabel *CustomLabel = [[UILabel alloc]initWithFrame:frame];
    CustomLabel.text = text;
    CustomLabel.textColor = textColor;
    CustomLabel.font = textSize;
    return [self initWithCustomView:CustomLabel];
}


- (instancetype)initWithCustomTextViewFrame:(CGRect)frame  textSize:(UIFont *)textSize  textColor:(UIColor *)textColor withText:(NSString *)text withImage:(NSString *)imageStr{
    
    UIButton *CustomBtn = [[UIButton alloc] initWithFrame:frame];
    [CustomBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [CustomBtn setTitle:[NSString stringWithFormat:@"  %@",text] forState:UIControlStateNormal];
    CustomBtn.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
    CustomBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    CustomBtn.titleLabel.font = textSize;
    CustomBtn.titleLabel.textColor = textColor;
    return [self initWithCustomView:CustomBtn];
}

//MARK:以下可能是业务需求写法
- (instancetype)initWithImage:(NSString *)image target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",image]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}

- (instancetype)initWithtextColor:(UIColor *)textColor Text:(NSString *)text target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button sizeToFit];
    button.titleLabel.textColor = textColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:button];
}
@end
