//
//  LoginViewController.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "LoginViewController.h"
#import "WeiboSDK.h"
#import "Header.h"
#import "Account.h"
#import "AFNetworking.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.引导用户到授权界面
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code",kAppKey,kRedirectURI];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //webview家在一个URL地址
    [self.webView loadRequest:request];
    self.webView.delegate = self;

    // Do any additional setup after loading the view.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //2.判断请求的地址是否是以回调地址开头，然后获取code
    //请求的URL地址
    NSURL *url= request.URL;
    //获取URL的string
    NSString *urlString = url.absoluteString;
    //字符串如果是以回调地址开头
    if ([urlString hasPrefix:kRedirectURI]) {
        NSLog(@"%@",urlString);
        NSArray *result = [urlString componentsSeparatedByString:@"code="];
        NSString *code = result.lastObject;
        //请求的access_token
        NSString *requestUrl = @"https://api.weibo.com/oauth2/access_token";
        NSDictionary *params = @{@"client_id":kAppKey,@"client_secret":kAppSecret,@"grant_type":@"authorization_code",@"code":code,@"redirect_uri":kRedirectURI};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        [manager POST:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            //保存登陆信息到单例model中
            [[Account currentAccount] saveLoginInfo:responseObject];
            [self dismissViewControllerAnimated:YES completion:nil];
            //清理当前的cookie
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (NSHTTPCookie *cookie in storage.cookies) {
                [storage deleteCookie:cookie];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            NSLog(@"%@",operation.responseString);
        }];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
