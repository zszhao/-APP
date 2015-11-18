//
//  SendStatusViewController.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SendStatusViewController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
@interface SendStatusViewController ()<WBHttpRequestDelegate>
@end

@implementation SendStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)sendStatus:(UIBarButtonItem *)sender {
    NSString *urlString = @"https://api.weibo.com/2/statuses/update.json";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *access_token = delegate.access_token;
    NSDictionary *params = @{@"access_token":access_token,@"status":self.textView.text};
    [WBHttpRequest requestWithURL:urlString httpMethod:@"POST" params:params delegate:self withTag:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@",response);
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@"%@",result);
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
