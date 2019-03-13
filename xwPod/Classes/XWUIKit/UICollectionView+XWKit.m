//
//  UICollectionView+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/8.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UICollectionView+XWKit.h"

@implementation UICollectionView (XWKit)

- (void)clearsSelection{
    NSArray *selectionItemIndexPaths = [self indexPathsForSelectedItems];
    for (NSIndexPath *indexPath in selectionItemIndexPaths) {
        [self deselectItemAtIndexPath:indexPath animated:YES];
    }
}

- (void)reloadDataKeepingSelection{
    NSArray *selectedIndexPaths = [self indexPathsForSelectedItems];
    [self  reloadData];
    for (NSIndexPath *indexPath in selectedIndexPaths) {
        [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

- (NSIndexPath *)indexPathForItemAtView:(id)sender{
    if (sender && [sender isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)sender;
        UICollectionViewCell *parentCell = [self parentCellForView:view];
        if (parentCell) {
            return [self indexPathForCell:parentCell];
        }
    }
    return nil;
}

- (UICollectionViewCell *)parentCellForView:(UIView *)view{
    if (!view.superview) {
        return nil;
    }
    if ([view.superview isKindOfClass:[UICollectionViewCell class]]) {
        return  (UICollectionViewCell *)view.superview;
    }
    return [self parentCellForView:view.superview];
}

- (BOOL)itemVisibleAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *visibleItemIndexPaths = self.indexPathsForSelectedItems;
    for (NSIndexPath *visibleIndexPath in visibleItemIndexPaths) {
        if ([indexPath  isEqual:visibleIndexPath]) {
            return YES;
        }
    }
    return NO;
}

- (NSIndexPath *)indexPathForFirstVisibleCell{
    NSArray *visibleIndexPaths = [self indexPathsForVisibleItems];
    if (!visibleIndexPaths || visibleIndexPaths.count <= 0) {
        return nil;
    }
    NSIndexPath *minimumIndexPath = nil;
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        if (!minimumIndexPath) {
            minimumIndexPath = indexPath;
            continue;
        }
        
        if (indexPath.section < minimumIndexPath.section) {
            minimumIndexPath = indexPath;
            continue;
        }
        
        if (indexPath.item < minimumIndexPath.item) {
            minimumIndexPath = indexPath;
            continue;
        }
    }
    return minimumIndexPath;
}
@end
