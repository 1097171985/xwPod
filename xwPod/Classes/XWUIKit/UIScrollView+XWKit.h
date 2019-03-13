//
//  UIScrollView+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/2.
//  Copyright © 2018年 xinwang2. All rights reserved.
//   主滚动  YYCategories  QMUIKit

#import <UIKit/UIKit.h>

@interface UIScrollView (XWKit)
/**
 判断ScrollView是否已经处在顶部（当ScrollView内容不够多不可滚动时，也认为是在顶部）
 */
@property (nonatomic, assign, readonly) BOOL alreadyAtTop;
/**
 判断ScrollView是否已经处在底部（当ScrollView内容不够多不可滚动时，也认为是在底部）
 */
@property (nonatomic, assign, readonly) BOOL alreadyAtBottom;
/**
 判断ScrollView是否已经处在最左边（当ScrollView内容不够多不可滚动时，也认为是在最左边）
 */
@property (nonatomic, assign, readonly) BOOL alreadyAtLeft;
/**
 判断ScrollView是否已经处在最右边（当ScrollView内容不够多不可滚动时，也认为是在最右边）
 */
@property (nonatomic, assign, readonly) BOOL alreadyAtRight;
/**
 ScrollView 的真正 inset，在iOS11以后需要用到 adjustedConetentInset 而在 ios11 以前只需要 用contentInset
 */
@property (nonatomic, assign, readonly) UIEdgeInsets xwContentInset; 
/**
 ScrollView 是否可以滚动

 @return yes or no
 */
- (BOOL)canScroll;
/**
 ScrollView 将滚动到顶部（带动画）
 */
- (void)scrollToTop;

/**
 ScrollView 将滚动到底部（带动画）
 */
- (void)scrollToBottom;

/**
 ScrollView 将滚动到最左边（带动画）
 */
- (void)scrollToLeft;

/**
 ScrollView 将滚动到最右边（带动画）
 */
- (void)scrollToRight;

/**
 ScrollView 是否带动画滚动到顶部

 @param animated yes or no
 */
- (void)scrollToTopAnimated:(BOOL)animated;

/**
 ScrollView 是否带动画滚动到底部

 @param animated yes or no
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 ScrollView 是否带动画滚动到最左边
 
 @param animated yes or no
 */
- (void)scrollToLeftAnimated:(BOOL)animated;

/**
 ScrollView 是否带动画滚动到最右边
 
 @param animated yes or no
 */
- (void)scrollToRightAnimated:(BOOL)animated;


/**
 立即停止滚动，用于那种手指已经离开屏幕但列表还在滚动的情况
 */
- (void)stopDeceleratingIfNeeded;
@end
