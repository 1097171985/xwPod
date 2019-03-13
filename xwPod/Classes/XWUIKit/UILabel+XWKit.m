//
//  UILabel+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/8.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import "UILabel+XWKit.h"

@implementation UILabel (XWKit)

- (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines Text:(NSString *)text {
    return [self initWithFont:font color:color alignment:alignment lines:lines shadowColor:[UIColor clearColor] Text:text];
}

+ (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines Text:(NSString *)text {
    return [self initWithFont:font color:color alignment:alignment lines:lines shadowColor:[UIColor clearColor] Text:text];
}


- (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)colorShadow Text:(NSString *)text {
    
    self = [super init];
    if (self) {
        [self setFont:font];
        [self setText:text];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:color];
        [self setShadowColor:colorShadow];
        [self setTextAlignment:alignment];
        [self setNumberOfLines:lines];
    }
    return self;
}

+ (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)colorShadow Text:(NSString *)text {
    
    UILabel *label = [[UILabel alloc]init];
    [label setFont:font];
    [label setText:text];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setShadowColor:colorShadow];
    [label setTextAlignment:alignment];
    [label setNumberOfLines:lines];
    
    return label;
}



- (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color SubStringArray:(NSArray *)subStringArray SubColorArray:(NSArray<UIColor *> *)colorArray  SubFontArray:(NSArray<UIFont *>*)fontArray Text:(NSString *)text {
    
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:font];
        self.attributedText = [self changeFontAndColorTotalString:text SubStringArray:subStringArray SubColorArray:colorArray SubFontArray:fontArray];
    }
    return self;
}

+ (instancetype)initWithFont:(UIFont *)font color:(UIColor *)color SubStringArray:(NSArray *)subStringArray SubColorArray:(NSArray<UIColor *> *)colorArray  SubFontArray:(NSArray<UIFont *>*)fontArray Text:(NSString *)text {
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextColor:color];
    [label setFont:font];
    label.attributedText = [label changeFontAndColorTotalString:text SubStringArray:subStringArray SubColorArray:colorArray SubFontArray:fontArray];
   
    return label;
}

- (NSMutableAttributedString *)changeFontAndColorTotalString:(NSString *)totalString SubStringArray:(NSArray *)subStringArray SubColorArray:(NSArray<UIColor *> *)colorArray  SubFontArray:(NSArray<UIFont *>*)fontArray{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    for (int i = 0; i < subStringArray.count; i++) {
        
        NSString *rangeStr = subStringArray[i];
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:range];
        [attributedStr addAttribute:NSFontAttributeName value:fontArray[i] range:range];
    }
    return attributedStr;
}

@end
