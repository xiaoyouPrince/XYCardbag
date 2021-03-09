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
    swith1.settingKey = SettingKey_EnableSound;
    swith1.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith1.settingKey];
    
    XYSwitch *swith2 = [XYSwitch new];
    swith2.settingKey = SettingKey_EnableSoundWithAlert;
    swith2.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith2.settingKey];
    
    NSArray *section1 = @[
        @{
            @"title": NSLocalizedString(@"设置",nil),
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"密码",nil),
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
            @"title": NSLocalizedString(@"操作卡片音效",nil),
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith1
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"音效伴随震动",nil),
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith2
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"语言",nil),
            @"titleKey": @"XYSettingLanguagesController",
            @"value": [kUserDefaults objectForKey:SettingKey_LanguageNameSetByUser] ?: @"iOS",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        }
    ];
    
    NSArray *section2 = @[
        @{
            @"title": NSLocalizedString(@"支持与反馈",nil),
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"分享",nil),
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"去 App Store 打分",nil),
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"请我喝杯咖啡",nil),
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"反馈",nil),
            @"titleKey": @"CommonViewController",
            @"value": @"xiaoyouPrince@gmail.com",
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
            @"title": NSLocalizedString(@"密码重置服务",nil),
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"启用密码重置服务",nil),
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"title": NSLocalizedString(@"如果你忘记了密码，可以通过此服务来找回密码",nil),
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        }
    ];
    
    
    NSString *touchIDorFaceID = @"假设目标设备都是支持的(不含iTouch)";
    NSString *touchIDorFaceIDTitle = @"";
    if (XYAuthenticationTool.authType == XYAuthTypeTouchID) {
        touchIDorFaceID = @"Touch ID";
        touchIDorFaceIDTitle = NSLocalizedString(@"通过 Touch ID 来解锁应用", nil);
    }else if(XYAuthenticationTool.authType == XYAuthTypeFaceID){
        touchIDorFaceID = @"Face ID";
        touchIDorFaceIDTitle = NSLocalizedString(@"通过 Face ID 来解锁应用", nil);
    }
    
    XYSwitch *swith1 = [XYSwitch new];
    swith1.settingKey = SettingKey_TouchID;
    swith1.valueChangedHandler = ^(BOOL isOn) {
        [kNotificationCenter postNotificationName:SettingKey_TouchID object:nil];
    };
    swith1.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith1.settingKey];
    NSArray *section2 = @[
        @{
            @"title": touchIDorFaceID,
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": touchIDorFaceIDTitle,
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
            @"title": NSLocalizedString(@"访问密码", nil),
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"启用密码", nil),
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith2
        },
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"设置访问密码", nil),
            @"titleKey": @"XYPasswordSettingController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        },
        @{
            @"title": NSLocalizedString(@"如果您想使用新的手势密码锁，请先移除现有密码，然后再重新设置密码", nil),
            @"titleColor": UIColor.grayColor,
            @"titleFont": [UIFont systemFontOfSize:14],
            @"type": @3,
            @"customCellClass": @"WechatTipCell",
        }
    ];
    
    
    NSInteger timeInterval = [kUserDefaults integerForKey:SettingKey_NeedPwdTimeInterval];
    NSString *timeStr = @"";
    if (timeInterval == 0) {
        timeStr = NSLocalizedString(@"立即",nil);
    }else if (timeInterval == 60) {
        timeStr = NSLocalizedString(@"1分钟后",nil);
    }else if (timeInterval == 180) {
        timeStr = NSLocalizedString(@"3分钟后",nil);
    }else if (timeInterval == 300) {
        timeStr = NSLocalizedString(@"5分钟后",nil);
    }else{
        timeStr = NSLocalizedString(@"10分钟后",nil);
    }
    NSArray *section4 = @[
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"需要密码",nil),
            @"titleKey": @"XYSettingNeedPwdTimeController",
            @"value": timeStr,
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        }
    ];
    
    XYSwitch *swith3 = [XYSwitch new];
    swith3.settingKey = NSLocalizedString(@"音效",nil);
    swith3.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith3.settingKey];
    NSArray *section5 = @[
        @{
            @"imageName": @"",
            @"title": NSLocalizedString(@"抹掉数据",nil),
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith3
        },
        @{
            @"title": NSLocalizedString(@"若连续10次输入错误密码，系统将抹掉所有卡片数据",nil),
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
                @"title": NSLocalizedString(@"访问密码",nil),
                @"titleColor": UIColor.grayColor,
                @"titleFont": [UIFont systemFontOfSize:14],
                @"type": @3,
                @"customCellClass": @"WechatTipCell",
            },
            @{
                @"imageName": @"",
                @"title": NSLocalizedString(@"启用密码",nil),
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
