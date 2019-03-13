//
//  UICollectionView+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/8.
//  Copyright © 2018年 xinwang2. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UICollectionView (XWKit)

/**
 清除所有已选中的item的选中状态
 */
- (void)clearsSelection;

/**
 重新reloadData,并且保持reloadData前item的选中状态
 */
- (void)reloadDataKeepingSelection;

/**
 获取某个view在collectionView内对应的indexPath
 例如某个view是某个cell里的subview，在这个view的点击事件回调方法里，就能通过`qmui_indexPathForItemAtView:`获取被点击的view所处的cell的indexPath
 @param sender view
 @return 注意返回的indexPath有可能为nil，要做保护。
 */
- (NSIndexPath *)indexPathForItemAtView:(id)sender;

/**
 判断当前indexPath 的item是否为可视的item

 @param indexPath inedexPath
 @return yes or no
 */
- (BOOL)itemVisibleAtIndexPath:(NSIndexPath *)indexPath;

/**
 获取可视区域内的第一个cell的indexPath
 为什么需要这个方法是因为系统的indexPathsForVisibleItems方法返回的数组成员是无序排列的，所以不能直接通过firstObject拿到第一个cell。
 @return indexPath
 */
- (NSIndexPath *)indexPathForFirstVisibleCell;
@end
