//
//  AppDelegate.m
//  XYCardbag
//
//  Created by xiaoyou on 2017/12/1.
//  Copyright © 2017年 xiaoyou. All rights reserved.
//

#import "AppDelegate.h"
#import "XYTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // 进入后台 - 检查是否需要密码(生成独立挡板来遮挡UI)
    BOOL pwdEnable = [kUserDefaults boolForKey:SettingKey_EnablePassword];
    if (pwdEnable) {
//        self.window
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 进入前台 - 检查是否需要密码
    BOOL pwdEnable = [kUserDefaults boolForKey:SettingKey_EnablePassword];
    if (pwdEnable) {
        
        BOOL touchID = [kUserDefaults boolForKey:SettingKey_TouchID];
        if (touchID) {
            [XYAuthenticationTool startAuthWithTip:@"登录一下下" reply:^(BOOL success, NSError * _Nonnull error) {
                if (success) {
                    NSLog(@"登录成功");
                    NSLog(@"error = %@",error);
                }else
                {
                    NSLog(@"登录失败");
                    NSLog(@"error = %@",error);
                }
            }];
        }
    }
    
    
    
}

@end
