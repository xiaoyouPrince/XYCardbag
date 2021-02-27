//
//  XYAlertView.m
//  MyMapDemo
//
//  Created by 渠晓友 on 2018/2/1.
//  Copyright © 2018年 XiaoYou. All rights reserved.
//

#import "XYAlertView.h"

@implementation XYAlertView

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message Ok:(void (^)(void))OK
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"我知道了"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // 确定
                                                         if (OK) {
                                                             OK();
                                                         }
                                                         
                                                     }];
    [av addAction:actionOK];
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)currentVc;
        [nav.visibleViewController presentViewController:av animated:YES completion:nil];
    }else{
       [currentVc presentViewController:av animated:YES completion:nil];
    }
    
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message Ok:(void (^)(void))OK cancel:(void (^)(void))cancel
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"好的"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                        // 确定
                                                         if (OK) {
                                                            OK();
                                                         }
                                                         
                                                     }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // cancel
                                                             if (cancel) {
                                                                 cancel();
                                                             }
                                                        
                                                         }];
    [av addAction:actionOK];
    [av addAction:actionCancel];
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)currentVc;
        [nav.visibleViewController presentViewController:av animated:YES completion:nil];
    }else{
        [currentVc presentViewController:av animated:YES completion:nil];
    }
    
}

+ (void)showDeveloping
{
    [self showAlertTitle:nil message:@"努力开发中..." Ok:nil];
}

@end
