//
//  NSDateFormatter+StatusDate.h
//  微博测试版APP
//
//  Created by qingyun on 15/11/16.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (StatusDate)
//根据时间字符串，转化为时间
- (NSDate *)statusDateWithString:(NSString *)dateString;
@end
