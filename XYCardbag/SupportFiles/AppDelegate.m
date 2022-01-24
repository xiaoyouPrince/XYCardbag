//
//  AppDelegate.m
//  XYCardbag
//
//  Created by xiaoyou on 2017/12/1.
//  Copyright © 2017年 xiaoyou. All rights reserved.
//

#import "AppDelegate.h"
#import "XYSettingViewController.h"
#import "XYClockView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 监听
    [kNotificationCenter addObserver:self selector:@selector(settingForLanguages) name:SettingKey_LanguageSetByUser object:nil];
    
    // 多语言
    [[XYLocalizedTool sharedInstance] setLanguage:[[XYLocalizedTool sharedInstance] currentLanguage]];
    
    
    

    return YES;
}

- (void)settingForLanguages{
    
    XYNavigationController *oldRootVC = (XYNavigationController *)self.window.rootViewController;
    XYNavigationController *newRootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle] instantiateInitialViewController];
    self.window.rootViewController = newRootVC;
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:[XYSettingViewController new]];
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [newRootVC.childViewControllers.firstObject presentViewController:nav animated:NO completion:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [oldRootVC popToRootViewControllerAnimated:NO];
            oldRootVC.viewControllers = @[];
//            free((__bridge void *)(oldRootVC));
        });
    });
        
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // 进入后台 - 检查是否需要密码(生成独立挡板来遮挡UI)
    BOOL pwdEnable = [kUserDefaults boolForKey:SettingKey_EnablePassword];
    if (pwdEnable) {
        
        if ([kUserDefaults integerForKey:SettingKey_NeedPwdTimeInterval] == 0) { //如果是立即，直接披上新遮挡View
            [self showClockView];
        }
        
        // 记录一下当前离开的时间、再次进入需要检验是否有展示密码
        [kUserDefaults setObject:[NSDate date] forKey:SettingKey_LastLeaveAppDate];
    }
}

- (void)showClockView{
    if (![self.window.subviews containsObject:[XYClockView sharedInstance]]) {
        XYClockView *coverView = [XYClockView sharedInstance];
        coverView.backgroundColor = UIColor.whiteColor;
        coverView.frame = self.window.bounds;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick:)];
        [coverView addGestureRecognizer:tap];
        
        [self.window addSubview:coverView];
    }
}

- (void)coverViewClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击");
    [self showFaceIDorTouchID];
}

- (void)showFaceIDorTouchID{
    
    [XYAuthenticationTool startAuthWithTip:@"解锁卡片助手" reply:^(BOOL success, NSError * _Nonnull error) {
        if (success) {
            NSLog(@"登录成功");
            NSLog(@"error = %@",error);
            
            XYClockView *coverView = [XYClockView sharedInstance];
            [coverView removeFromSuperview];
            
        }else
        {
            NSLog(@"登录失败");
            NSLog(@"error = %@",error);
        }
    }];
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
        if ([currenDate compare:[lastLeaveDate dateByAddingTimeInterval:needPwdTime]] == NSOrderedDescending) { // 当前比预设时间晚了，展示密码
            
            // 未开 faceID/touchID 展示白板
            [self showClockView];
            
            BOOL touchID = [kUserDefaults boolForKey:SettingKey_TouchID];
            if (touchID) {
                [self showFaceIDorTouchID];
            }
        }
    }
}

@end
