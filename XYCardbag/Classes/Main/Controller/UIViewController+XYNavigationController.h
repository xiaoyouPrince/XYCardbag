//
//  UIViewController+XYNavigationController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/21.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XYNavigationController)

/** 设置是否禁用侧滑返回 default is NO*/
@property (nonatomic, assign)         BOOL xy_disablePopGesture;

/** 侧滑返回手势屏占比 default is 10% */
@property (nonatomic, assign)         CGFloat xy_popGestureRatio;


@end

NS_ASSUME_NONNULL_END
