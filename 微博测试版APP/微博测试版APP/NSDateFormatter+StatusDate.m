//
//  NSDateFormatter+StatusDate.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/16.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "NSDateFormatter+StatusDate.h"

@implementation NSDateFormatter (StatusDate)
- (NSDate *)statusDateWithString:(NSString *)dateString
{
    NSString *formatterString = @"EEE MMM dd HH:mm:ss zzz yyyy";
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
    self.locale = usLocale;
    //指定时间格式化格式
    self.dateFormat = formatterString;
    return [self dateFromString:dateString];
}
@end
