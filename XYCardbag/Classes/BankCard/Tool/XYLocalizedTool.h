//
//  XYLocalizedTool.h
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/5.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

//  一个国际化工具，方便设置语言

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const AppLanguage = @"appLanguage";

@interface XYLocalizedTool : NSObject

+ (instancetype)sharedInstance;

//初始化多语言功能
- (void)initLanguage;

//当前语言
- (NSString *)currentLanguage;

//设置要转换的语言
- (void)setLanguage:(NSString *)language;

//设置为系统语言
- (void)systemLanguage;

@end

@interface NSBundle (language)
// 设置语言
+ (void)setLanguage:(NSString *)language;
@end

NS_ASSUME_NONNULL_END
