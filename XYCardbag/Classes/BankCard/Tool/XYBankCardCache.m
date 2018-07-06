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
    
    //NSString *sql = @"";
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:section];  // 这里的意思是Status必须实现Coding协议
        // 2.存储数据
        BOOL isSuccess = [db executeUpdate:@"insert into t_section (name, icon,section) values(?, ? ,?)", section.title, section.icon ,data];
        if (isSuccess) {
            DLog(@"保存成功");
        }
    }];
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
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:section];  // 这里的意思是Status必须实现Coding协议
        
        // 2.存储数据
        BOOL isSuccess = [db executeUpdate:@"delete from t_section where section = ?", data];
        if (isSuccess) {
            DLog(@"移除成功");
        }
    }];
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
    all.title = @"全部卡片";
    all.icon = @"category_icon_all";
    
    XYBankCardSection *favorite = [XYBankCardSection new];
    favorite.title = @"我最喜欢";
    favorite.icon = @"category_icon_17";
    
    [arrayM addObject:all];
    [arrayM addObject:favorite];
    
    
    
    // 1.定义resutlArray
    NSMutableArray *resultArrayM = @[].mutableCopy;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        FMResultSet *rs = nil;
        
        rs = [db executeQuery:@"select * from t_section"];
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"section"];
            XYBankCardSection *section = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [resultArrayM addObject:section];
        }
    }];
    
    
    // 3. 拼接查询结果中的section
    [arrayM addObjectsFromArray:resultArrayM];
    
    return arrayM;
}

/**
 查询某组下面所有卡片
 */
+ (NSMutableArray <XYBankCardModel *>*)getAllCardModelsForSection:(XYBankCardSection *)section{
    
    
    NSMutableArray * resultArrayM = [NSMutableArray array];
    
    // 1.创建语句
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM t_card WHERE t_card.sid = (SELECT t_section.id FROM t_section WHERE t_section.name = ?)",section.title];
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        FMResultSet *rs = nil;
        
        rs = [db executeQuery:querySql];
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"card"];
            XYBankCardModel *card = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [resultArrayM addObject:card];
        }
    }];
    
    return resultArrayM;
}


@end
