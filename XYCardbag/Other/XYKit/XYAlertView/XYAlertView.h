//
//  XYAlertView.h
//  MyMapDemo
//
//  Created by 渠晓友 on 2018/2/1.
//  Copyright © 2018年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAlertView : NSObject

/// 只是一个通知类型的alert
+ (void)showAlertTitle:(NSString *)title message:(NSString *)message Ok:(void (^)(void))OK;

/// 两个选择的alert <OK/Cancel>
+ (void)showAlertTitle:(NSString *)title message:(NSString *)message Ok:(void (^)(void))OK cancel:(void (^)(void))cancel;

@end
