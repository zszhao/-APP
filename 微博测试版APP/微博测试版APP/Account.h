//
//  Account.h
//  微博测试版APP
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSDate *expires;

+ (instancetype)currentAccount;
- (void)saveLoginInfo:(NSDictionary *)info;
- (BOOL)isLogin;
- (NSMutableDictionary *)requestParameters;
- (void)logOut;
@end
