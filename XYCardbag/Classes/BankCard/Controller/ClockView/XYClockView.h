//
//  XYClockView.h
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/3.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

// 一个上锁View， 需要密码解锁
// 单例，全局唯一

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYClockView : UIView

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
