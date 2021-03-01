//
//  DataTool.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/1.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "DataTool.h"
#import "XYSwitch.h"

@implementation DataTool

+ (NSArray *)settingData{
    
    /**
     关于 - 关于项目/开发者
     设置 - 密码、iCloud、音效、语言
     推荐 - 微信、微博、QQ + 复制链接
     当前版本 - 作为一个尾巴放下边
     */
    
    XYSwitch *swith1 = [XYSwitch new];
    swith1.settingKey = @"音效";
    swith1.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith1.settingKey];
    
    NSArray *section1 = @[
        @{
            @"title": @"设置",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": @"密码",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": @"iCloud",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": swith1.settingKey,
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith1
        },
        @{
            @"imageName": @"",
            @"title": @"语言",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        }
    ];
    
    NSArray *section2 = @[
        @{
            @"title": @"支持与反馈",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": @"分享",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": @"去 App Store 打分",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": @"请我喝杯咖啡",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": @"反馈",
            @"titleKey": @"CommonViewController",
            @"value": @"邮箱?",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        }
    ];
    
    return @[section1,section2];
}

@end
