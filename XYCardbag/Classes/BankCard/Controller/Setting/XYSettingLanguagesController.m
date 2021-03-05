//
//  XYSettingLanguagesController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/5.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

// 三种语言 : 跟随系统 / English / 简体中文
/*
    逻辑: 用户第一次进入App默认是跟随系统的。
    后续:
 */


#import "XYSettingLanguagesController.h"
#import "XYLocalizedTool.h"

@interface XYSettingLanguagesController ()

@end

@implementation XYSettingLanguagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBgColor;
    
    // 只有首次备份一下系统语言
    if (![kUserDefaults objectForKey:SettingKey_LanguageSystem]) {
        NSArray *langs = [NSLocale preferredLanguages];
        [kUserDefaults setObject:langs forKey:SettingKey_LanguageSystem];
    }
    
    XYCheckBoxItem *item0 = [XYCheckBoxItem modelWithTitle:@"跟随系统" code:@"0" select:NO];
    XYCheckBoxItem *item1 = [XYCheckBoxItem modelWithTitle:@"English" code:@"en" select:NO];
    XYCheckBoxItem *item2 = [XYCheckBoxItem modelWithTitle:@"简体中文" code:@"zh-Hans" select:NO];
    NSArray *dataArray = @[item0, item1, item2];
    
    for (XYCheckBoxItem *item in dataArray) {
        if ([item.code isEqualToString:[kUserDefaults stringForKey:SettingKey_LanguageSetByUser]]) {
            item.select = YES;
        }
    }
    
    XYCheckBox *cb = [XYCheckBox checkBoxWithHeaderView:nil dataArray:dataArray isMutex:YES allowCancelSelected:NO itemSelectedHandler:^(XYCheckBoxItem * _Nonnull item) {
//        // 设置选中项目
//        if ([item.code isEqualToString:@"0"]) { // 跟随系统
//            [[NSUserDefaults standardUserDefaults] setObject:[kUserDefaults objectForKey:SettingKey_LanguageSystem] forKey:@"AppleLanguages"];
//        }else{ // 自定
//            [[NSUserDefaults standardUserDefaults] setObject:@[item.code] forKey:@"AppleLanguages"];
//        }
        
//        [kUserDefaults setObject:item.code forKey:SettingKey_LanguageSetByUser];
        
        [[XYLocalizedTool sharedInstance] setLanguage:item.code];
        
        // 通知刷新
        [kNotificationCenter postNotificationName:SettingKey_LanguageSetByUser object:nil];
    }];
    cb.backgroundColor = UIColor.whiteColor;
    
    [self setContentView:cb edgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
}

@end
