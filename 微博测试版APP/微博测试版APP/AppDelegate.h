//
//  AppDelegate.h
//  微博测试版APP
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic,strong) NSString *access_token;
@property (strong, nonatomic) UIWindow *window;
- (void)guideEnd;

@end

