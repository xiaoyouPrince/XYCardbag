//
//
//  XYBankCardCache.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/5.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYBankCardCache.h"
#import "FMDB.h"

@implementation XYBankCardCache

// 声明一个只有本文件能用的数据库全局队列
static FMDatabaseQueue *_queue;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"cards.sqlite"];
    
    DLog(@"%@",path);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表 section 和 card
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_section ("
                                 "id integer primary key autoincrement,"
                                 "name text,"
                                 "icon blob,"
                                 "section blob"
                                 ");"
         ];
        
        [db executeUpdate:@"create table if not exists t_card ("
                                 "id integer primary key autoincrement,"
                                 "name text,"
                                 "frontImage blob,"
                                 "rearImage blob,"
                                 "sid integer,"
                                 "card blob,"
                                 "CONSTRAINT fk_section FOREIGN KEY(sid) REFERENCES t_section(id)"
                                 ");"
         ];
    }];
}


#pragma mark -- 查询卡的信息

#pragma mark -- 增
/**
 存储新的卡片分组
 */
+ (void)saveNewCardSection:(XYBankCardSection *)section{
    
}

/**
 给某个卡片分组添加新的卡片
 */
+ (void)saveNewCard:(XYBankCardModel *)card forSection:(XYBankCardSection *)section{
    
}


#pragma mark -- 删

/**
 删除某个卡片分组
 */
+ (void)deleteCardSection:(XYBankCardSection *)section{
    
}

/**
 在某个卡片分组中删除某卡片
 */
+ (void)deleteCard:(XYBankCardModel *)card forSection:(XYBankCardSection *)section{
    
}


#pragma mark -- 改

/**
 更新某个卡分组中某个卡片的信息
 */
+ (void)updateCardInfo:(XYBankCardModel *)card forSection:(XYBankCardSection *)section{
    
}

#pragma mark -- 查

/**
 查询所有卡片分组
 */
+ (NSMutableArray <XYBankCardSection *>*)getAllCardSections{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    // 内部默认【全部】【我的最爱】两个分组
    XYBankCardSection *all = [XYBankCardSection new];
    all.title = @"全部";
    all.icon = @"all";
    
    XYBankCardSection *favorite = [XYBankCardSection new];
    favorite.title = @"我最喜欢";
    favorite.icon = @"favorite";
    
    [arrayM addObject:all];
    [arrayM addObject:favorite];
    
    return arrayM;
}

/**
 查询某组下面所有卡片
 */
+ (NSMutableArray <XYBankCardModel *>*)getAllCardModelsForSection:(XYBankCardSection *)section{
    return [NSMutableArray array];
}


@end
