//
//  UITableView+IndexWithIndexPath.h
//  微博测试版APP
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (IndexWithIndexPath)
//根据indexpath计算出cell在table中的index
- (NSInteger)indexWithIndexPath:(NSIndexPath *)indexPath;
@end
