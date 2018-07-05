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

@interface XYBankCardSection : NSObject

@property(nonatomic , copy) NSString *title;
@property(nonatomic , copy) NSString *icon;

@end

@interface XYBankCardModel : NSObject

@property(nonatomic , copy) NSString *frontIcon;
@property(nonatomic , copy) NSString *rearIcon;

@property(nonatomic , copy) NSString *name;
@property(nonatomic , copy) NSString *cardNumber;
@property(nonatomic , copy) NSString *desc; // 描述
@end
