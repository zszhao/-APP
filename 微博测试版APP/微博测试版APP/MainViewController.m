//
//  MainViewController.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/9.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "Header.h"
#import "Account.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[Account currentAccount] isLogin]) {
        self.selectedIndex = 0;
    }else{
        self.selectedIndex = 2;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:kLogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:kLoginNotification object:nil];
    // Do any additional setup after loading the view.
}
- (void)logout:(NSNotification *)notification
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNav"];
    [self presentViewController:vc animated:YES completion:nil];
    self.selectedIndex = 2;
}
- (void)login:(NSNotification *)notification
{
    self.selectedIndex = 0;
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
