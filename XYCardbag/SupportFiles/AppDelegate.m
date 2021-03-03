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
        
        if ([kUserDefaults integerForKey:SettingKey_NeedPwdTimeInterval] == 0) { //如果是立即，直接披上新遮挡View
            UIView *coverView = [UIView new];
            coverView.backgroundColor = UIColor.whiteColor;
            coverView.frame = self.window.bounds;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick:)];
            [coverView addGestureRecognizer:tap];
            
            [self.window addSubview:coverView];
        }
        
        // 记录一下当前离开的时间、再次进入需要检验是否有展示密码
        [kUserDefaults setObject:[NSDate date] forKey:SettingKey_LastLeaveAppDate];
    }
}

- (void)coverViewClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    XYFunc
    // 进入前台 - 检查是否需要密码
    BOOL pwdEnable = [kUserDefaults boolForKey:SettingKey_EnablePassword];
    if (pwdEnable) {
        
        NSInteger needPwdTime = [kUserDefaults integerForKey:SettingKey_NeedPwdTimeInterval];
        NSDate *lastLeaveDate = [kUserDefaults objectForKey:SettingKey_LastLeaveAppDate];
        NSDate *currenDate = [NSDate date];
        if ([currenDate laterDate:[lastLeaveDate dateByAddingTimeInterval:needPwdTime]]) { // 当前比预设时间晚了，展示密码
            
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
            }else
            {
                // 未开 faceID/touchID 展示白板
                UIView *coverView = [UIView new];
                coverView.backgroundColor = UIColor.whiteColor;
                coverView.frame = self.window.bounds;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick:)];
                [coverView addGestureRecognizer:tap];
                
                [self.window addSubview:coverView];
            }
        }
    }
}

@end
