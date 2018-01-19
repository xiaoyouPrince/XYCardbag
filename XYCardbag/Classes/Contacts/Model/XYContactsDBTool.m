//
//  XYContactsDBTool.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/18.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYContactsDBTool.h"
#import "FMDB.h"

@implementation XYContactsDBTool
{
    FMDatabase *db;
}

static NSString *tableName = @"t_contacts";

+ (instancetype)sharedInstance
{
    static XYContactsDBTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        // 创建数据库，并打开
        [instance creatDBAndOpen];
    });
    return instance;
}

- (void)creatDBAndOpen{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"contacts.db"];
    db = [db initWithPath:path];
    if ([db open]) {
        DLog(@"contacts.db 创建成功");
        
        // 创建一个数据表
        NSString *sql = @"create table if not exists t_contacts(id integer primary key autoincrement,name text , phoneNum text , email text)";
        BOOL success = [db executeUpdate:sql];
        if (success) {
            DLog(@"t_contacts 建表成功");
        }else
        {
            DLog(@"t_contacts 建表失败");
        }
    }else
    {
        DLog(@"contacts.db 创建打开失败");
    }
}

- (NSMutableArray *)getAllContacts
{
    NSString *sql = @"select * from t_contacts";
    FMResultSet *set = [db executeQuery:sql];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    while ([set next]) {
        [arrayM addObject:[set objectForColumn:@"id"]];
    }
    return arrayM;
}

- (void)addContact:(NSString *)name phoneNum:(NSString *)phoneNum email:(NSString *)email
{
    NSString *sql = @"insert into t_contacts(name , phoneNum , email) values(?,?,?)";
    
    if ([db executeUpdateWithFormat:sql,name,phoneNum,email]) {
        DLog(@"保存 contacts 成功");
    }else
    {
        DLog(@"保存 contacts 失败");
    }
}

@end
