//
//  UITableView+XWKit.h
//  XWUIKit
//
//  Created by xinwang2 on 2017/12/8.
//  Copyright © 2017年 xinwang2. All rights reserved.
//  创建 UITableView

#import <UIKit/UIKit.h>

@interface UITableView (XWKit)

/**
 创建 UITableView
 
 @param frame frame description
 @param style style description
 @param cellSeparatorStyle cellSeparatorStyle description
 @param separatorInset separatorInset description
 @param dataSource dataSource description
 @param delegate delegate
 @return Returns the created UITableView
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                 style:(UITableViewStyle)style
                    cellSeparatorStyle:(UITableViewCellSeparatorStyle)cellSeparatorStyle
                        separatorInset:(UIEdgeInsets)separatorInset
                            dataSource:(id <UITableViewDataSource> _Nullable)dataSource
                              delegate:(id <UITableViewDelegate> _Nullable)delegate;

/**
 获取section下的所有row
 
 @param section section
 @return return rowsArray
 */
- (NSArray * _Nonnull)getIndexPathsForSection:(NSUInteger)section;

/**
 获取下一个NSIndexPath
 
 @param row 当前的row
 @param section 当前的section
 @return return Next NSIndexPath
 */
- (NSIndexPath * _Nonnull)getNextIndexPath:(NSUInteger)row   forSection:(NSUInteger)section;

/**
 获取上一个NSIndexPath
 
 @param row 当前的row
 @param section 当前的section
 @return return Previous NSIndexPath
 */
- (NSIndexPath * _Nonnull)getPreviousIndexPath:(NSUInteger)row
                                    forSection:(NSUInteger)section;
@end
