//
//  UITableView+IndexWithIndexPath.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "UITableView+IndexWithIndexPath.h"

@implementation UITableView (IndexWithIndexPath)
- (NSInteger)indexWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = 0;
    //当前的section之前section一共有多少行
    for (int i = 0; i < indexPath.section; i++) {
        index += [self numberOfRowsInSection:i];
    }
    //加上当前的行数
    index += indexPath.row;
    return index;
}
@end
