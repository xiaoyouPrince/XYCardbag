//
//
//  XYBankCardCache.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/5.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

//  缓存银行卡的信息

#import <Foundation/Foundation.h>
#import "XYBankCardModel.h"

@interface XYBankCardCache : NSObject


#pragma mark -- 增
/**
 存储新的卡片分组
 */
+ (void)saveNewCardSection:(XYBankCardSection *)section;

/**
 给某个卡片分组添加新的卡片
 */
+ (void)saveNewCard:(XYBankCardModel *)card forSection:(XYBankCardSection *)section;


#pragma mark -- 删

/**
 删除某个卡片分组
 */
+ (void)deleteCardSection:(XYBankCardSection *)section;

/**
 在某个卡片分组中删除某卡片
 */
+ (void)deleteCard:(XYBankCardModel *)card forSection:(XYBankCardSection *)section;


#pragma mark -- 改

/**
 更新某个卡分组中某个卡片的信息
 */
+ (void)updateCardInfo:(XYBankCardModel *)card forSection:(XYBankCardSection *)section;

#pragma mark -- 查

/**
 查询所有卡片分组
 */
+ (NSMutableArray <XYBankCardSection *>*)getAllCardSections;

/**
 查询某组下面所有卡片,参数为有title的section即可，内部依据title查询
 */
+ (NSMutableArray <XYBankCardModel *>*)getAllCardModelsForSection:(XYBankCardSection *)section;



@end
