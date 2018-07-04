//
//  XYContactsDBTool.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/18.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//
//  关于联系人数据的的保存和处理

#import <Foundation/Foundation.h>
@class XYContacts;

@interface XYContactsDBTool : NSObject

+ (instancetype)sharedInstance;
- (NSMutableArray *)getAllContacts;
- (void)addContact:(XYContacts *)contact;
- (void)addContact:(NSString *)name phoneNum:(NSString *)phoneNum email:(NSString *)email;

@end
