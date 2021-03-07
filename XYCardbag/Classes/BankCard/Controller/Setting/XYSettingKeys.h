//
//  XYSettingKeys.h
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/3.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import <Foundation/Foundation.h>

// 是否启用 TouchID 或者 FaceID
UIKIT_EXTERN NSString  * const SettingKey_TouchID;
// 是否启用密码
UIKIT_EXTERN NSString  * const SettingKey_EnablePassword;
// 是否启用输入10次错误密码，清理所有数据
UIKIT_EXTERN NSString  * const SettingKey_DeleteAllDataWhen10TimesError;

// 进入后台后，需要密码的时间单位秒
UIKIT_EXTERN NSString  * const SettingKey_NeedPwdTimeInterval;
// 上次离开App(进入后台)的时间 NSDate
UIKIT_EXTERN NSString  * const SettingKey_LastLeaveAppDate;

// 是否启用音效
UIKIT_EXTERN NSString  * const SettingKey_EnableSound;
// 音效和震动
UIKIT_EXTERN NSString  * const SettingKey_EnableSoundWithAlert;

// 用户设置的语言
UIKIT_EXTERN NSString  * const SettingKey_LanguageSetByUser;
