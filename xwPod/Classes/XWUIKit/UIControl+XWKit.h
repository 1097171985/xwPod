//
//  UIControl+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/8.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (XWKit)

/**
 是否接管 UIcontrol 的 touch 事件
 uicontrol 在 UIscrollView 上会有300毫秒的延迟，默认情况下快速点击某一个UIcontrol，将不会看到setHighlighted的效果，
 如果通过将UIscrollview.delaysContentTouchs置为no来取消这个延迟，则系统给无法判断touch时是要点击还是要滚动。
 此时可以将UIcontrol.automaticllyAdjustTouchHightedInScrollView属性置为yes,会使用自己的一套计算方法去判断触发sethighlighted的时机
 从而保证既不影响UIscrollview的滚动，又能让UI是control 在被快速点击时也能立马看到setHighLighted的效果
 @waring 使用了这个属性则不需要设置UIscrollview.delaysContentTouches;
 */
@property (nonatomic,assign) BOOL automaticallyAdjustTouchHightedInScrollView;

/**
 影响区域需要改变大小，负值表示往外扩大，正值表示往里缩小
 */
@property (nonatomic,assign) UIEdgeInsets outsideEdge;

/**
 setHighlighted: 方法的回调block
 */
@property (nonatomic,copy)  void(^XWsetHighlightBlcok)(BOOL highlighted);

/**
 为分类添加block属性
 设置UIControlEventTouchUpInside点击事件
 */
@property (nonatomic,copy)  void(^Block)(id sender);

/**
 设置事件

 @param target 目标
 @param action 方法
 @param controlEvents 事件类型
 */
- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 设置事件

 @param controlEvents 事件类型
 @param block 返回事件
 */
- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void(^)(id sender))block;

/**
 设置事件

 @param controlEvents 事件类型
 @param block 返回事件
 */
- (void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 删除所有block事件

 @param controlEvents 事件类型
 */
- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

@end
