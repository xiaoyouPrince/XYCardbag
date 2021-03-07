//
//  XYSettingLanguagesController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/5.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

// 两种种语言 :  English / 简体中文
/*
逻辑:
    仿微信只展示支持的语言，用户选择什么就是什么
    用户选完保存用户选择，发全局通知让 AppDelegate 重新设置 RootVC
 */


#import "XYSettingLanguagesController.h"
#import "XYLocalizedTool.h"

@interface XYSettingLanguagesController ()

@end

@implementation XYSettingLanguagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBgColor;

    XYCheckBoxItem *item1 = [XYCheckBoxItem modelWithTitle:@"English" code:@"en" select:NO];
    XYCheckBoxItem *item2 = [XYCheckBoxItem modelWithTitle:@"简体中文" code:@"zh-Hans" select:NO];
    NSArray *dataArray = @[item1, item2];
    
    for (XYCheckBoxItem *item in dataArray) {
        if ([item.code isEqualToString:[kUserDefaults stringForKey:SettingKey_LanguageSetByUser]]) {
            item.select = YES;
        }
    }
    
    XYCheckBox *cb = [XYCheckBox checkBoxWithHeaderView:nil dataArray:dataArray isMutex:YES allowCancelSelected:NO itemSelectedHandler:^(XYCheckBoxItem * _Nonnull item) {

        // 设置语言
        [[XYLocalizedTool sharedInstance] setLanguage:item.code];
        [kUserDefaults setObject:item.title forKey:SettingKey_LanguageNameSetByUser];
        
        // 通知刷新
        [kNotificationCenter postNotificationName:SettingKey_LanguageSetByUser object:nil];
    }];
    cb.backgroundColor = UIColor.whiteColor;
    
    [self setContentView:cb edgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
}

@end
