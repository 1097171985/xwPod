//
//  UIScrollView+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/2.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIScrollView+XWKit.h"

@implementation UIScrollView (XWKit)

- (BOOL)alreadyAtTop{
    if (![self canScroll]) {
        return  YES;
    }
    if (self.contentOffset.y == - self.contentInset.top) {
        return YES;
    }
    return NO;
}

- (BOOL)alreadyAtBottom{
    if (![self canScroll]) {
        return YES;
    }
    if(self.contentOffset.y == self.contentSize.height + self.contentInset.bottom -  CGRectGetHeight(self.bounds)){
        return YES;
    }
    return NO;
}

- (BOOL)alreadyAtLeft{
    if (![self canScroll]) {
        return YES;
    }
    if (self.contentOffset.x == - self.contentInset.left) {
        return YES;
    }
    return NO;
}

- (BOOL)alreadyAtRight{
    if (![self canScroll]) {
        return YES;
    }
    if (self.contentOffset.x == self.contentSize.width + self.contentInset.right - CGRectGetWidth(self.bounds)) {
        return  YES;
    }
    return NO;
}

- (UIEdgeInsets)xwContentInset {
    if (@available(iOS 11, *)) {
        return self.adjustedContentInset;
    } else {
        return self.contentInset;
    }
}

- (BOOL)canScroll{
    
    if (self.bounds.size.width <= 0 || self.bounds.size.height <= 0) {
        return NO;
    }
    BOOL canVerticalScroll = self.contentSize.height + self.contentInset.top + self.contentInset.bottom > CGRectGetHeight(self.bounds);
    BOOL canHorizontalScoll = self.contentSize.width + self.contentInset.left + self.contentInset.right > CGRectGetWidth(self.bounds);
    return canVerticalScroll || canHorizontalScoll;
}

- (void)scrollToTop{
    [self  scrollToTopAnimated:YES];
}

- (void)scrollToBottom{
    [self scrollToBottomAnimated:YES];
}

- (void)scrollToLeft{
    [self scrollToLeftAnimated:YES];
}

- (void)scrollToRight{
    [self scrollToRightAnimated:YES];
}

- (void)scrollToTopAnimated:(BOOL)animated{
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated{
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated{
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated{
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

- (void)stopDeceleratingIfNeeded {
    if (self.decelerating) {
        [self setContentOffset:self.contentOffset animated:NO];
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,contentInset = %@",[super description],NSStringFromUIEdgeInsets(self.contentInset)];
}
@end
