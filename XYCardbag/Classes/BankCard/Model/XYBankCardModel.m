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

@implementation XYBankCardSection
MJCodingImplementation;

+ (instancetype)instanceWithTitle:(NSString *)title
{
    XYBankCardSection *section = [XYBankCardSection new];
    section.title = title;
    return section;
}

@end


@implementation XYBankCardModel
MJCodingImplementation;
@end
