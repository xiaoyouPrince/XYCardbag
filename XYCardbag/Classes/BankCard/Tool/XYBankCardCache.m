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
    
    // 2.创表 t_section 和 t_card
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
                                 "favorite integer,"
                                 "name text,"
                                 "frontImage blob,"
                                 "rearImage blob,"
                                 "sid integer,"
                                 "card blob,"
                                 "CONSTRAINT fk_section FOREIGN KEY(sid) REFERENCES t_section(id)"
                                 ");"
         ];
    }];
    
    // 3. 创建两个默认组 【全部】 & 【我的最爱】
    XYBankCardSection *all = [XYBankCardSection new];
    all.title = SectionNameAll;
    all.icon = @"category_icon_all";
    
    XYBankCardSection *favorite = [XYBankCardSection new];
    favorite.title = SectionNameFavroit;
    favorite.icon = @"category_icon_17";
    
    [self saveNewCardSection:all];
    [self saveNewCardSection:favorite];
    
    
}


#pragma mark - 查询卡的信息

#pragma mark - 增
/**
 存储新的卡片分组
 */
+ (void)saveNewCardSection:(XYBankCardSection *)section{
    
    /// @warning 先验证同名卡片组然后进行存储
    
    __block BOOL hasRecord = NO;
    [_queue inDatabase:^(FMDatabase *db) { // 0.1 先验证是否已经有同名的卡片组
        
        // 1.获得需要存储的数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:section];  // 须实现Coding协议
        // 创建数组
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"SELECT t_section.name FROM t_section WHERE t_section.name = ?", section.title];
        while (rs.next) {
            hasRecord = YES;
        }
        
        // 2.存储数据
        if (!hasRecord) { // 如果不存在原有的section,再进行存储
            BOOL isSuccess = [db executeUpdate:@"insert into t_section (name, icon,section) values(?, ? ,?)", section.title, section.icon ,data];
            
            if (isSuccess) {
                DLog(@"保存成功");
                
                // 保存 sectionID
                int64_t sectionID = [db lastInsertRowId];
                section.sectionID = [NSNumber numberWithLongLong:sectionID];
            }
        }
    }];
}

/**
 给某个卡片分组添加新的卡片
 */
+ (void)saveNewCard:(XYBankCardModel *)card forSection:(XYBankCardSection *)section{
    
    // 1.获得需要存储的数据
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:card];  // 必须实现Coding协议
    
    if ([section.sectionID isEqualToNumber:@(1)]) { /* 【所有卡片】和 普通卡片组一样无需处理 */ }
    if ([section.sectionID isEqualToNumber:@(2)]) { /* 【我的最爱】 t_card.favorite is ture */
        // 在这个分组中添加卡片默认 t_card.favorite is ture
        card.isFavorite = @(YES);
    }
    
    // 这里不可以这么写，参数data是二进制，导致insertSql为一个特别大的str，违背原本意义。它只是个sql语句即可，参数就是参数即可.因为data参数在z字符串中为  <62706c69 73743030> 格式，而 < > 括号为非法sql语句字符
    // NSString *insertSql = [NSString stringWithFormat:@"insert into t_card ( sid, name , favorite, card) values ( %@, %@, %@ , %@)", section.sectionID, card.name ,card.isFavorite ,data];;
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        // 2.存储数据
        BOOL isSuccess = [db executeUpdate:@"insert into t_card ( sid, name , favorite, card) values ( ?, ?, ? , ?)", section.sectionID, card.name ,card.isFavorite, data];

        if (isSuccess) {
            DLog(@"保存成功");
//            NSInteger cardID = [db];
        }
    }];
    
}


#pragma mark - 删

/**
 删除某个卡片分组
 */
+ (void)deleteCardSection:(XYBankCardSection *)section{
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        // 2.存储数据
        BOOL isSuccess = [db executeUpdate:@"delete from t_section where (id = ?)", section.sectionID];
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


#pragma mark - 改

/**
 更新某个卡分组中某个卡片的信息
 */
+ (void)updateCardInfo:(XYBankCardModel *)card forSection:(XYBankCardSection *)section{
    
}

/**
 设置卡片是否为喜欢

 @param card 无论外界是够设置过 card.isFavorite = yes,仅以参数 favorite 为准来设置最终结果
 */
+ (void)updateCardInfo:(XYBankCardModel *)card forFavorite:(BOOL)favorite
{
    card.isFavorite = favorite ? @(YES) : @(NO);
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:card];
    
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL isSuccess = [db executeUpdate:@"update t_card set favorite = ?,"
                          "card = ?"
                          "where t_card.id = ?",card.isFavorite,data,card.cardID];
        if (isSuccess) {
            DLog(@"设置%@成功", favorite ? @"喜欢":@"取消喜欢");
        }
        
    }];
}

#pragma mark - 查

/**
 查询所有卡片分组
 */
+ (NSMutableArray <XYBankCardSection *>*)getAllCardSections{

    NSMutableArray *arrayM = [NSMutableArray array];
    
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
            
            // 保存其对应的sectionID
            int64_t sectionID = [rs intForColumn:@"id"];
            section.sectionID = [NSNumber numberWithLongLong:sectionID];
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
//    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM t_card WHERE t_card.sid = (SELECT t_section.id FROM t_section WHERE t_section.name = \"%@\")",section.title];
    
    
    // 1.【所有卡片】分组
    NSString *queryAll = [NSString stringWithFormat:@"SELECT * FROM t_card"];
    
    // 2.【我的最爱】分组
    NSString *queryFavorite = [NSString stringWithFormat:@"SELECT * FROM t_card WHERE t_card.favorite = %@",@(YES)];
    
    // 3.普通分组
    NSString *queryNormal = [NSString stringWithFormat:@"SELECT * FROM t_card WHERE t_card.sid = %@",section.sectionID];
    
    NSString *querySql = queryNormal;
    if ([section.sectionID isEqualToNumber:@(1)]) {
        querySql = queryAll;
    }
    if ([section.sectionID isEqualToNumber:@(2)]) {
        querySql = queryFavorite;
    }
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        FMResultSet *rs = nil;
        
        rs = [db executeQuery:querySql];
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"card"];
            XYBankCardModel *card = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            if (card == nil) { // 早期版本存储的时候没有此数据，这里做一下加固，防止奔溃
                
            }else{
                
                // 卡片id
                int64_t cardID = [rs intForColumn:@"id"];
                card.cardID = [NSNumber numberWithLongLong:cardID];
                [resultArrayM addObject:card];
            }
        }
    }];
    
    return resultArrayM;
}


@end
