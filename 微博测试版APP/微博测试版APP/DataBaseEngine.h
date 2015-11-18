//
//  DataBaseEngine.h
//  微博测试版APP
//
//  Created by qingyun on 15/11/16.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseEngine : NSObject
//将网络请求的所有微博字典保存
+ (void)saveStatus2DataBase:(NSArray *)statuses;
//查询微博记录
+ (NSArray *)statusFromDB;
@end
