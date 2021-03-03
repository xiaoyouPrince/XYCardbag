//
//  DataTool.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/1.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "DataTool.h"
#import "XYSwitch.h"
#import <LocalAuthentication/LocalAuthentication.h>

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
            @"titleKey": @"XYPasswordSettingController",
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


+ (NSArray *)settingPasswordData
{
    NSArray *section1 = @[
        @{
            @"title": @"密码重置服务",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": @"启用密码重置服务",
            @"titleKey": @"XYPasswordSettingController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"title": @"如果你忘记了密码，可以通过此服务来找回密码",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        }
    ];
    
    XYSwitch *swith1 = [XYSwitch new];
    swith1.settingKey = SettingKey_TouchID;
    swith1.valueChangedHandler = ^(BOOL isOn) {
        [kNotificationCenter postNotificationName:SettingKey_TouchID object:nil];
    };
    swith1.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith1.settingKey];
    NSArray *section2 = @[
        @{
            @"title": @"Touch ID",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": @"通过指纹解锁应用",
            @"titleKey": @"XYPasswordSettingController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith1
        },
    ];
    
    XYSwitch *swith2 = [XYSwitch new];
    swith2.settingKey = SettingKey_EnablePassword;
    swith2.valueChangedHandler = ^(BOOL isOn) {
        [kNotificationCenter postNotificationName:SettingKey_EnablePassword object:nil];
    };
    swith2.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith2.settingKey];
    NSArray *section3 = @[
        @{
            @"title": @"访问密码",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": @"启用密码",
            @"titleKey": @"XYPasswordSettingController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith2
        },
        @{
            @"imageName": @"",
            @"title": @"设置访问密码",
            @"titleKey": @"XYPasswordSettingController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"title": @"如果您想使用新的手势密码锁，请先移除现有密码，然后再重新设置密码",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        }
    ];
    
    NSArray *section4 = @[
        @{
            @"imageName": @"",
            @"title": @"需要密码",
            @"titleKey": @"XYPasswordSettingController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        }
    ];
    
    XYSwitch *swith3 = [XYSwitch new];
    swith3.settingKey = @"音效";
    swith3.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith3.settingKey];
    NSArray *section5 = @[
        @{
            @"imageName": @"",
            @"title": @"抹掉数据",
            @"titleKey": @"XYPasswordSettingController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith3
        },
        @{
            @"title": @"若连续10次输入错误密码，系统将抹掉所有卡片数据",
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        }
    ];
    
    BOOL enablePwd = [kUserDefaults boolForKey:SettingKey_EnablePassword];
    if (enablePwd) {
        return @[section1, section2, section3, section4, section5];
    }else
    {
        NSArray *section6 = @[
            @{
                @"title": @"访问密码",
                @"titleColor": UIColor.grayColor,
                @"titleFont": [UIFont systemFontOfSize:14],
                @"type": @3,
                @"customCellClass": @"WechatTipCell",
            },
            @{
                @"imageName": @"",
                @"title": @"启用密码",
                @"titleKey": @"XYPasswordSettingController",
                @"value": @"",
                @"type": @1,
                @"valueCode": @"",
                @"cellHeight": @50,
                @"accessoryView": swith2
            }
        ];
        
        return @[section1, section6];
    }
    
}

@end
