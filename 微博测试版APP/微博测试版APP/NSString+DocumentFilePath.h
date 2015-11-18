//
//  NSString+DocumentFilePath.h
//  微博测试版APP
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DocumentFilePath)
//根据文件名返回文件路径
+ (NSString *)filePathWithName:(NSString *)name;
@end
