//
//  UITextView+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/12.
//  Copyright © 2017年 xinwang2. All rights reserved.
//

#import "UITextView+XWKit.h"
#import <objc/runtime.h>
static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLD = @"placehold";
static NSString *WORDCOUNTLABEL = @"wordcount";
static const void *limitLengthKey = &limitLengthKey;
static void       *XWplaceholderFrame = &XWplaceholderFrame;
static const void *XWBlockKey = &XWBlockKey;

@interface UITextView ()

@property (nonatomic,strong) UILabel *placeholderLabel;//占位符

@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数

@end


@implementation UITextView (XWKit)

- (void)setLimitBlock:(XWLimitLengthBlock)limitBlock{
    
     objc_setAssociatedObject(self, XWBlockKey, limitBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(XWLimitLengthBlock)limitBlock{
    return objc_getAssociatedObject(self, XWBlockKey);
}

//显示占位符label的setter/getter方法
-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);
}

//显示字数label的setter/getter方法
- (void)setWordCountLabel:(UILabel *)wordCountLabel {
    objc_setAssociatedObject(self, &WORDCOUNTLABEL, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)wordCountLabel {
    return objc_getAssociatedObject(self, &WORDCOUNTLABEL);
}

//供外接访问的占位字符串，以便设置占位文字的setter/getter方法
- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}

- (NSString *)placeholder {
    return objc_getAssociatedObject(self, &PLACEHOLD);
}

//供外接访问的最大输入字数，设置最大文字个数的setter/getter方法
- (NSNumber *)limitLength {
    return objc_getAssociatedObject(self, &limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addLimitLengthObserver:[limitLength intValue]];
    [self setWordcountLable:limitLength];
}

//MARK: 配置占位符标签
- (void)setPlaceHolderLabel:(NSString *)placeholder {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self];
    // 占位字符
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = self.font;
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.]} context:nil];
    self.placeholderLabel.frame = CGRectMake(7, 7, rect.size.width, rect.size.height);
    [self addSubview:self.placeholderLabel];
    self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
}


-(void)setPlaceholderFrame:(CGRect)placeholderFrame{
    self.placeholderLabel.frame = placeholderFrame;
    objc_setAssociatedObject(self, &placeholderFrame, @(placeholderFrame), OBJC_ASSOCIATION_ASSIGN);
}

- (CGRect)placeholderFrame{
    NSNumber *numberValue = objc_getAssociatedObject(self, &XWplaceholderFrame);
    return [numberValue CGRectValue];
}


//MARK: 设置字数限制标签
- (void)setWordcountLable:(NSNumber *)limitLength {
    //字数限制
    self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 65, CGRectGetHeight(self.frame) - 20, 60, 20)];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.font = self.font;
    if (self.text.length > [limitLength integerValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,limitLength];
    [self addSubview:self.wordCountLabel];
}

//MARK: 注册限制位数的通知
- (void)addLimitLengthObserver:(int)length {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextViewTextDidChangeNotification object:self];
}

//MARK: 限制输入的位数
- (void)limitLengthEvent {
    
    if ([self.text length] > [self.limitLength intValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
}

//MARK: NSNotification
- (void)textFieldChanged:(NSNotification *)notification {
    if (self.placeholder) {
        self.placeholderLabel.hidden = YES;
        if (self.text.length == 0) {
            self.placeholderLabel.hidden = NO;
        }
    }
    if (self.limitLength) {
        
        NSInteger wordCount = self.text.length;
        if (wordCount > [self.limitLength integerValue]) {
            wordCount = [self.limitLength integerValue];
//MARK: -- 想提示用户输入已经超出最大字数可以打开此行代码
            self.limitBlock(wordCount);
            
        }
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%@",wordCount,self.limitLength];
    }
}
    
@end
