//
//  XYContacts.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/17.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYContacts : NSObject

/// 名字
@property(nonatomic , copy) NSString *name;
/// 电话号码
@property(nonatomic , copy) NSString *phoneNum;
/// 邮箱地址
@property(nonatomic , copy) NSString *email;

@end
