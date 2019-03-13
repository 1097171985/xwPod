//
//  XWUIKitCommonDefines.h
//  XWUIKit
//
//  Created by xinwang2 on 2018/2/27.
//  Copyright © 2018年 xinwang2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

//MARK: --变量-编译相关
#ifdef DEBUG
#define IS_DEBUG YES
#else
#define IS_DEBUG NO
#endif

#define ScreenBoundsSize ([[UIScreen mainScreen] bounds].size)
#define ScreenNativeBoundsSize ([[UIScreen mainScreen] nativeBounds].size)
#define ScreenScale ([[UIScreen mainScreen] scale])
#define ScreenNativeScale ([[UIScreen mainScreen] nativeScale])

//MARK:判断当前编译的版本
//是否为iOS 8.0 及 以上
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
#define IOS8_SDK_ALLOWED  YES
#endif

//是否为iOS 9.0 及 以上
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
#define IOS9_SDK_ALLOWED  YES
#endif

//是否为iOS 10.0 及 以上
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#define IOS10_SDK_ALLOWED  YES
#endif

//是否为iOS 11.0 及 以上
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
#define IOS11_SDK_ALLOWED  YES
#endif


//MARK: --方法-c对象、结构操作
//MARK:交换方法
CG_INLINE BOOL
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    if (!newMethod) {
        // class 里不存在该方法的实现
        return NO;
    }
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}

/**
 在某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为标志位而不是数值），可能导致一些精度问题，
 所以提供这个方法快速将 CGFLOAT_MIN 转换为 0

 @param floatValue 设置的最小值
 @return CGFLOAT_MIN
 */
CG_INLINE CGFloat
removeFloatMin(CGFloat floatValue){
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}

/**
 基于指定的倍数，对传进来的floatValue 进行像素取整。
 若指定倍数为0，则表示以当前设备的屏幕倍数为准
 例如：传进来 “2.1” ，在2x 倍数下返回2.5 (0.5pt 对应 1px),在3x 倍数下返回2.333 (0.333pt 对应 1px),

 @param floatValue 值
 @param scale 倍数
 @return 返回的值
 */
CG_INLINE CGFloat
flatSpecificScale(CGFloat floatValue,CGFloat scale){
    floatValue = removeFloatMin(floatValue);
    scale = scale == 0 ? ScreenScale : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 基于当前设备的屏幕倍数，对传进来的floatvalue 进行像素取整
  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，
  若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale

 @param floatValue 值
 @return 返回的值
 */
CG_INLINE CGFloat
flat(CGFloat floatValue){
    return flatSpecificScale(floatValue, 0);
}

/**
 类似flat(),只不过flat是向上取整，而floorInPixel 是向下取整

 @param floatValue 值
 @return 返回的值
 */
CG_INLINE CGFloat
floorInPixel(CGFloat floatValue){
    floatValue = removeFloatMin(floatValue);
    CGFloat resultValue = floor(floatValue * ScreenScale) / ScreenScale;
    return resultValue;
}

/**
 判断值是否在最小和最大之间（不相等）

 @param minimumValue 最小值
 @param value 输入值
 @param maximumValue 最大值
 @return 返回的值
 */
CG_INLINE BOOL
between(CGFloat minimumValue,CGFloat value,CGFloat maximumValue){
    return minimumValue < value && value < maximumValue;
}

/**
 判断值是否在最小和最大之间（相等）

 @param minimumValue 最小值
 @param value 输入的值
 @param maximumValue 最大值
 @return 返回的值
 */
CG_INLINE BOOL
betweenOrEqual(CGFloat minimumValue,CGFloat value,CGFloat maximumValue){
    return minimumValue <= value && value <= maximumValue;
}

/**
 调整给定的某个 CGFloat 值的小数点精度，超过精度的部分按四舍五入处理。
 例如 CGFloatToFixed(0.3333, 2) 会返回 0.33，而 CGFloatToFixed(0.6666, 2) 会返回 0.67
 @warning 参数类型为 CGFloat，也即意味着不管传进来的是 float 还是 double 最终都会被强制转换成 CGFloat 再做计算
 @param value 输入的值
 @param precisition 保留小数位数
 @return 返回的值
 */
CG_INLINE CGFloat
CGFloatToFixed(CGFloat value,NSUInteger precisition){
    NSString *formatString = [NSString stringWithFormat:@"%%.%@f",@(precisition)];
    NSString *toString = [NSString stringWithFormat:formatString,value];
#if defined(__LP64__) && __LP64__
    CGFloat result = [toString doubleValue];
#else
    CGFloat result = [toString floatValue];
#endif
    return result;
}

//MARK:获取UIedgeInsets在水平方向上的值
/**
 获取UIedgeInsets在水平方向上的值

 @param insets UIedgeInsets
 @return 返回的值
 */
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
/**
 获取UIEdgeInsets在垂直方向上的值

 @param insets UIEdgeInsets
 @return 返回的值
 */
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}


/**
 判断一个size是否为空（宽或者高为0）

 @param size size
 @return 返回的值
 */
CG_INLINE BOOL
CGSizeIsEmpty(CGSize size){
    return size.width <= 0 || size.height <= 0;
}

/**
 判断一个 CGRect 是否存在NaN

 @param rect rect
 @return 返回的值
 */
CG_INLINE BOOL
CGRectIsNaN(CGRect rect) {
    return isnan(rect.origin.x) || isnan(rect.origin.y) || isnan(rect.size.width) || isnan(rect.size.height);
}

/**
 系统提供的 CGRectIsInfinite 接口只能判断 CGRectInfinite 的情况，而该接口可以用于判断 INFINITY 的值

 @param rect rect description
 @return 返回的值
 */
CG_INLINE BOOL
CGRectIsInf(CGRect rect) {
    return isinf(rect.origin.x) || isinf(rect.origin.y) || isinf(rect.size.width) || isinf(rect.size.height);
}

/**
 判断一个 CGRect 是否合法（例如不带无穷大的值、不带非法数字）

 @param rect rect description
 @return 返回的值
 */
CG_INLINE BOOL
CGRectIsValidated(CGRect rect) {
    return !CGRectIsNull(rect) && !CGRectIsInfinite(rect) && !CGRectIsNaN(rect) && !CGRectIsInf(rect);
}

