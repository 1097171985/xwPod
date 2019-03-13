//
//  UIGestureRecognizer+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/8.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (XWKit)

/**
 初始化手势

 @param block block事件
 @return 返回手势
 */
- (instancetype)initWithActionBlock:(void (^)(id sender))block;

/**
 添加手势

 @param block block事件
 */
- (void)addActionBlock:(void (^)(id sender))block;

/**
 移除所有的block事件
 */
- (void)removeAllActionBlocks;
@end
