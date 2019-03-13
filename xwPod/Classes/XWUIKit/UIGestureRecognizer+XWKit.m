//
//  UIGestureRecognizer+XWKit.m
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/8.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import "UIGestureRecognizer+XWKit.h"
#import <objc/runtime.h>

static const int block_key;

@interface XWUIGestureRecognizer : NSObject

@property (nonatomic,copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;

- (void)invoke:(id)sender;

@end


@implementation XWUIGestureRecognizer

- (id)initWithBlock:(void (^)(id))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender{
    if (_block) _block(sender);
}

@end

@implementation UIGestureRecognizer (XWKit)

- (instancetype)initWithActionBlock:(void (^)(id))block{
    self = [self init];
    if (self) {
        [self addActionBlock:block];
    }
    return self;
}

- (void)addActionBlock:(void (^)(id))block{
    XWUIGestureRecognizer *target = [[XWUIGestureRecognizer alloc]initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)removeAllActionBlocks{
    NSMutableArray *targets = [self allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeTarget:obj action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)allUIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
