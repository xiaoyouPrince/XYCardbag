//
//  UIViewController+XYNavigationController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/21.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "UIViewController+XYNavigationController.h"
#import <objc/runtime.h>


@implementation UIViewController (XYNavigationController)

- (void)setXy_disablePopGesture:(BOOL)xy_disablePopGesture
{
    objc_setAssociatedObject(self, @selector(setXy_disablePopGesture:), @(xy_disablePopGesture), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)xy_disablePopGesture
{
    return [objc_getAssociatedObject(self, @selector(setXy_disablePopGesture:)) boolValue];
}

- (void)setXy_popGestureRatio:(CGFloat)xy_popGestureRatio
{
    objc_setAssociatedObject(self, @selector(setXy_popGestureRatio:), @(xy_popGestureRatio), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)xy_popGestureRatio
{
    return [objc_getAssociatedObject(self, @selector(setXy_popGestureRatio:)) doubleValue];
}

@end
