//
//
//  XYBankCardModel.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/5.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYBankCardModel.h"

NSString * const SectionNameAll = @"所有卡片";
NSString * const SectionNameFavroit = @"我的最爱";

@implementation XYBankCardSection
MJCodingImplementation;

+ (instancetype)instanceWithSectionID:(NSNumber *)sectionID
{
    XYBankCardSection *section = [XYBankCardSection new];
    section.sectionID = sectionID;
    return section;
}

@end


@implementation XYBankCardModel
- (instancetype)init{
    if(self == [super init]){
        _tags = [NSMutableArray array];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"frontIcon = %@, rearIcon = %@ ,frontIconData = %@, rearIconData = %@ , name = %@ , cardNumber = %@ , desc = %@ , tags = %@",_frontIcon,_rearIcon,_frontIconImage,_rearIconImage,_name,_cardNumber,_desc,_tags];
}

MJCodingImplementation;
@end
