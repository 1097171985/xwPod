//
//  UISearchBar+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/9.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UISearchBar+XWKit.h"
#import <objc/runtime.h>

static char *XWMakViewKey = "XWMakViewKey";
static void *XWMskBoolkey = &XWMskBoolkey;

@interface MaskView:UIView

@end

@implementation MaskView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.superview endEditing:YES];
}

@end

@implementation UISearchBar (XWKit)

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor blueColor];
        self.backgroundColor = [UIColor redColor];
        self.searchMaskBool = YES;
    }
    return self;
}

- (instancetype)init{
    self = [self init];
    if (self) {
        self.searchMaskBool = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.searchMaskBool = YES;
    }
    return self;
}

//MARK:setter && getter
- (MaskView *)maskView{
    
    MaskView *maskView = (MaskView *)objc_getAssociatedObject(self, XWMakViewKey);
    if (maskView == nil) {
        maskView = [[MaskView alloc]init];
        [maskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        maskView.frame = CGRectMake(0, 0, 100, 100);
         objc_setAssociatedObject(self, XWMakViewKey, maskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return maskView;
}


//MARK: --Methods
- (void)showMaskView{
    CGRect mainViewBounds = [[UIApplication sharedApplication] keyWindow].bounds;
    CGRect rect = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
    CGRect contextViewFrame = CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetWidth(rect), CGRectGetHeight(mainViewBounds) - CGRectGetMaxY(rect));
    [[self maskView] setFrame:contextViewFrame];
    [[self maskView] setAlpha:0.0f];
    [self.window addSubview:[self maskView]];
    
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction | UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        [[self maskView]setAlpha:0.6];
    } completion:^(BOOL finished) {}];
}

- (void)removeMaskView{
    [UIView animateKeyframesWithDuration:0.2
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction | UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  [[self maskView] setAlpha:0.0f];
                              } completion:^(BOOL finished) {
                                  [[self maskView] removeFromSuperview];
                              }];
}

//MARK: UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textFIELD{
    self.searchMaskBool = YES;
    if (self.searchMaskBool) {
        [self showMaskView];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.searchMaskBool) {
        [self removeMaskView];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

-(void)setSearchMaskBool:(BOOL)searchMaskBool{
    
    objc_setAssociatedObject(self, &XWMskBoolkey, @(searchMaskBool), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)searchMaskBool{
    
    NSNumber *numberValue = objc_getAssociatedObject(self, &XWMskBoolkey);
    return [numberValue boolValue];
}
@end
