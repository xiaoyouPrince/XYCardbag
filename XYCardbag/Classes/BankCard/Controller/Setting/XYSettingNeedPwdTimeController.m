//
//  XYSettingNeedPwdTimeController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/3.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

// 设置需要密码的时间
// 立即、 1 分钟、 3 分钟、 5分钟、 10分钟

#import "XYSettingNeedPwdTimeController.h"

@interface XYSettingNeedPwdTimeController ()

@end

@implementation XYSettingNeedPwdTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBgColor;
    
    XYCheckBoxItem *item0 = [XYCheckBoxItem modelWithTitle:XYLocalizedString(@"立即") code:@"0" select:NO];
    XYCheckBoxItem *item1 = [XYCheckBoxItem modelWithTitle:XYLocalizedString(@"1分钟后") code:@"60" select:NO];
    XYCheckBoxItem *item2 = [XYCheckBoxItem modelWithTitle:XYLocalizedString(@"3分钟后") code:@"180" select:NO];
    XYCheckBoxItem *item3 = [XYCheckBoxItem modelWithTitle:XYLocalizedString(@"5分钟后") code:@"300" select:NO];
    XYCheckBoxItem *item4 = [XYCheckBoxItem modelWithTitle:XYLocalizedString(@"10分钟后") code:@"600" select:NO];
    NSArray *dataArray = @[item0, item1, item2, item3, item4];
    
    for (XYCheckBoxItem *item in dataArray) {
        if (item.code.integerValue == [kUserDefaults integerForKey:SettingKey_NeedPwdTimeInterval]) {
            item.select = YES;
        }
    }
    
    XYCheckBox *cb = [XYCheckBox checkBoxWithHeaderView:nil dataArray:dataArray isMutex:YES allowCancelSelected:NO itemSelectedHandler:^(XYCheckBoxItem * _Nonnull item) {
        // 设置选中项目
        NSInteger needPwdTime = [item.code integerValue];
        [kUserDefaults setInteger:needPwdTime forKey:SettingKey_NeedPwdTimeInterval];
        // 通知刷新
        [kNotificationCenter postNotificationName:SettingKey_NeedPwdTimeInterval object:nil];
    }];
    cb.backgroundColor = UIColor.whiteColor;
    
    [self setContentView:cb edgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
}

@end
