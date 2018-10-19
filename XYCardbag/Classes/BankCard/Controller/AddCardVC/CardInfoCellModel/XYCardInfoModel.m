//
//
//  XYCardInfoModel.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYCardInfoModel.h"

@implementation XYCardInfoModel
MJCodingImplementation;

- (NSString *)tagString
{
    // 基于 tagType 来定义的，自定义的标签中的类型string
    switch (self.tagType) {
        case TagTypeBaseImage:
        case TagTypeBaseName:
        case TagTypeBaseNumber:
        case TagTypeBaseDesc:
            return @"基础标签";// 这几类不用管
            break;
        case TagTypeDate:
            return @"日期";
            break;
        case TagTypePhoneNumber:
            return @"电话";
            break;
        case TagTypeMail:
            return @"邮件";
            break;
        case TagTypeNetAddress:
            return @"网址";
            break;
        case TagTypeCustom:
            return @"其他";
            break;
        case TagTypeAdd:
            return @"站位";
            break;
            
        default:
            break;
    }
}


@end
