//
//  homeTableViewController.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "homeTableViewController.h"
#import "Header.h"
#import "AFNetworking.h"
#import "Account.h"
#import "StatusTableViewCell.h"
#import "StatusModel.h"
#import "DataBaseEngine.h"
@interface homeTableViewController ()
@property (nonatomic,strong) NSArray *statuses;
@end

@implementation homeTableViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadData];
}
- (void)loadData
{
    //URL地址，还有请求的需要提交的参数
    NSString *urlString = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSDictionary *params = [[Account currentAccount] requestParameters];
    //未登陆的判断
    if (!params) {
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        //请求到的数据，首先转化为model，然后再使用
        //self.statuses = responseObject[@"statuses"];
        NSArray *statusesInfo = responseObject[@"statuses"];
        NSMutableArray *resutArray = [NSMutableArray arrayWithCapacity:statusesInfo.count];
        //遍历每一个status字典，并且转化为model，保存在resultarray中
        [statusesInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            StatusModel *model = [[StatusModel alloc] initWithStatusInfo:obj];
            [resutArray addObject:model];
        }];
        //将所有的model作为数据源
        self.statuses = resutArray;
        //更新数据源后刷新UI
        [self.tableView reloadData];
        //保存到数据库中，下一次启动，从数据库中查询
        [DataBaseEngine saveStatus2DataBase:statusesInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.statuses = [DataBaseEngine statusFromDB];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell"forIndexPath:indexPath];
    
    // Configure the cell...
    [cell bandingStatusModel:self.statuses[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusModel *status = self.statuses[indexPath.row];
    NSString *text = status.text;
    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 16, MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    CGRect band = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return 81 + band.size.height + 8 + 1;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
