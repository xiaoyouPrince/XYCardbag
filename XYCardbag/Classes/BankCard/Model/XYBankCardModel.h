//
//
//  XYBankCardModel.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/5.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const SectionNameAll;
FOUNDATION_EXPORT NSString * const SectionNameFavroit;

@interface XYBankCardSection : NSObject

@property(nonatomic , copy) NSNumber *sectionID; // 卡片组的id
@property(nonatomic , copy) NSString *title;
@property(nonatomic , copy) NSString *icon;

/**
 根据title 快速创建一个对象
 */
+ (instancetype)instanceWithSectionID:(NSNumber *)sectionID;

@end

@interface XYBankCardModel : NSObject

@property(nonatomic , copy) NSNumber *cardID; // 卡片id
@property(nonatomic , copy) NSNumber *isFavorite; // 设置喜欢

@property(nonatomic , strong) UIImage *frontIconImage;
@property(nonatomic , strong) UIImage *rearIconImage;

@property(nonatomic , copy) NSString *name;
@property(nonatomic , copy) NSString *cardNumber;
@property(nonatomic , copy) NSString *desc; // 描述
@property(nonatomic , strong) NSMutableArray  *tags; // 其他的标签

@end
