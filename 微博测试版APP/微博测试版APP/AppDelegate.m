//
//  AppDelegate.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "Header.h"
#define kVersionKey @"VersionKey"
@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    self.window.rootViewController = [story instantiateViewControllerWithIdentifier:@"guide"];
    self.window.rootViewController = [self instantiateRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}
- (id)instantiateRootViewController
{
    //取出APP运行的版本
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //根据储存的标示符，判断应用是否是该版本第一次运行，返回不同的控制器
    //取出本地存储的标示符
    NSString *version = [userDefaults objectForKey:kVersionKey];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //判断本地标示符与当前版本标示符是否一致
    if ([currentVersion isEqualToString:version]) {
        //不是第一次运行，返回tabbar控制器，作为主控制器
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"main"];
        return vc;
    }else{
        //是第一次运行，返回引导页控制器
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"guide"];
        //第一次运行后，就存储标示符
        [userDefaults setObject:currentVersion forKey:kVersionKey];
        [userDefaults synchronize];
        return vc;
    }
    
    
}
- (void)guideEnd
{
    UIStoryboard *story = self.window.rootViewController.storyboard;
    //初始化根视图控制器
    self.window.rootViewController = [story instantiateViewControllerWithIdentifier:@"main"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"%@",response);
    WBAuthorizeResponse *auRes = (WBAuthorizeResponse *)response;
    self.access_token = auRes.accessToken;
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"%@",request);
}
@end
