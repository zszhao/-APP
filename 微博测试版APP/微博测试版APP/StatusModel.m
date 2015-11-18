//
//  StatusModel.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/16.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "StatusModel.h"
#import "Header.h"
#import "NSDateFormatter+StatusDate.h"
#import "UsersModel.h"
@implementation StatusModel
- (instancetype)initWithStatusInfo:(NSDictionary *)status
{
    self = [super init];
    if (self) {
        NSString *created = status[kStatusCreateTime]
        ;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //将字符串按照格式转化为时间
        self.created_at = [formatter statusDateWithString:created];
        self.text = status[kStatusText];
        self.source = [self sourceWithString:status[kStatusSource]];
        self.user = [[UsersModel alloc] initWithUserInfo:status[kStatusUserInfo]];
        NSDictionary *retweeted = status[kStatusRetweetStatus];
        //根据是否有字典，来初始化相对应的model
        if (retweeted) {
            self.retweeted_status = [[StatusModel alloc] initWithStatusInfo:retweeted];
        }
        self.repost_count = status[kStatusRepostsCount];
        self.comments_count = status[kStatusCommentsCount];
        self.attitudes_count = status[kStatusAttitudesCount];
        self.pic_urls = status[kStatusPicUrls];
    }
    return self;
}
//重写get方法
- (NSString *)createdString
{//计算出时间差（微博创建时间和当前时间）
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.created_at];
    if (interval < 60) {
        return @"刚刚";
    }else if (interval < 60*60){
        return [NSString stringWithFormat:@"%d 分钟前",(int)interval/60];
    }else if (interval < 24*60*60){
        return [NSString stringWithFormat:@"%d 小时前",(int)interval/(60*60)];
    }else if (interval < 24*60*60*30){
        return [NSString stringWithFormat:@"%d 天前",(int)interval/(60*60*24)];
    }else{
        return [NSDateFormatter localizedStringFromDate:self.created_at dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    }
}
-(NSString *)sourceWithString:(NSString *)string{
    //<a href=\"http://app.weibo.com/t/feed/310OQS\" rel=\"nofollow\">\U7cbe\U5f69\U5fae\U5ba2</a>
    
    //正则表达式规则
    NSString *regExStr = @">.*<";
    //根据规则生成正则表达式
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regExStr options:0 error:nil];
    //使用正则表达式，在字符串中查询符合条件的结果
    NSTextCheckingResult *result = [expression firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    if (result) {
        NSRange range = result.range;
        NSString *rsultString = [string substringWithRange:NSMakeRange(range.location + 1, range.length - 2)];
        return rsultString;
        
    }
    
    return nil;
    
    
}
@end
