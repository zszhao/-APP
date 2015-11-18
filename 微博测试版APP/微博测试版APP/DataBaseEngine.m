//
//  DataBaseEngine.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/16.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "DataBaseEngine.h"
#import "Header.h"
#import "DataBaseEngine.h"
#import "NSString+DocumentFilePath.h"
#import "FMDB.h"
#import "StatusModel.h"
static NSArray *statusTableColums;
@implementation DataBaseEngine
+ (void)initialize
{
    //建数据路文件copy到document下
    [DataBaseEngine copyFile2Documents];
    //查询出table的所有字段
    statusTableColums = [DataBaseEngine tableColum:kStatusTableName];
}
+ (void)copyFile2Documents
{
    NSString *source = [[NSBundle mainBundle] pathForResource:@"status" ofType:@"db"];
    NSString *toPath = [NSString filePathWithName:kStatusFileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:toPath]) {
        [manager copyItemAtPath:source toPath:toPath error:nil];
    }
}
+ (NSArray *)tableColum:(NSString *)tableName
{
    //创建db
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathWithName:kStatusFileName]];
    //打开db
    if (![db open]) {
        NSLog(@"%@",db.lastError);
    }
    //执行查询，查询所有字段的信息
    FMResultSet *result = [db getTableSchema:tableName];
    NSMutableArray *columns = [NSMutableArray array];
    while ([result next]) {
        [columns addObject:[result objectForColumnName:@"name"]];
    }
    //关闭db
    [db close];
    return columns;
}
+ (void)saveStatus2DataBase:(NSArray *)statuses
{
    //创建一个数据库操作队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSString filePathWithName:kStatusFileName]];
    [queue inDatabase:^(FMDatabase *db) {
        [statuses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //遍历数组中的微博dic，保存到数据库
            NSDictionary *statusInfo = obj;
            //取出字典的allkey
            NSArray *allKey = statusInfo.allKeys;
            //跟table column 比较，得出交集
            NSArray *containKeys = [DataBaseEngine compare:allKey SecondArray:statusTableColums];
            //生成SQL语句
            NSString *sqlString = [DataBaseEngine createdSqlString:containKeys];
            //生成只包含交集key的字典
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
            [containKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                //取出obj这个key对应的value
                id value = statusInfo[obj];
                //如果value的class是数组，或者字典，就归档为二进制数据，才可以保存到数据库中
                if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
                    //将value转化为二进制数据
                    value = [NSKeyedArchiver archivedDataWithRootObject:value];
                }
                //保存到结果字典中
                [resultDic setObject:value forKey:obj];
            }];
            //执行插入
            BOOL result = [db executeUpdate:sqlString withParameterDictionary:resultDic];
        }];
    }];
}
//比较两个数组，得出交集
+ (NSArray *)compare:(NSArray *)firstArray SecondArray:(NSArray *)secondArray
{
    NSMutableArray *result = [NSMutableArray array];
    [firstArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([secondArray containsObject:obj]) {
            [result addObject:obj];
        }
    }];
    return [result copy];
}
+ (NSString *)createdSqlString:(NSArray *)allKey
{
    NSString *columnString = [allKey componentsJoinedByString:@", "];
    NSString *keyString = [allKey componentsJoinedByString:@", :"];
    keyString = [@":" stringByAppendingString:keyString];
    return [NSString stringWithFormat:@"insert into %@ (%@) values(%@)",kStatusTableName,columnString,keyString];
}
+ (NSArray *)statusFromDB
{
    //从数据库中查询之前保存的数据
    NSString *sqlString = @"select * from status order by id desc limit 20";
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathWithName:kStatusFileName]];
    [db open];
    FMResultSet *resultSet = [db executeQuery:sqlString];
    NSMutableArray *resultArray = [NSMutableArray array];
    while ([resultSet next]) {
        //将一行记录转化为字典
        NSDictionary *resultDic = resultSet.resultDictionary;
        //将二进制数据解档
        NSMutableDictionary *resultMudic = [NSMutableDictionary dictionaryWithDictionary:resultDic];
        [resultDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            //如果值的类型是NSData，那么将值解档后才能使用
            if ([obj isKindOfClass:[NSData class]]) {
                id object = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
                [resultMudic setObject:object forKey:key];
            }
            //如果值是NSNull类型，那么从字典中排除
            if ([obj isKindOfClass:[NSNull class]]) {
                [resultMudic removeObjectForKey:key];
            }
        }];
        StatusModel *status = [[StatusModel alloc] initWithStatusInfo:resultMudic];
        [resultArray addObject:status];
    }
    return resultArray;
}
@end
