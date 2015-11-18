//
//  StatusTableViewCell.m
//  微博测试版APP
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "StatusModel.h"
#import "UsersModel.h"
@implementation StatusTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)bandingStatusModel:(StatusModel *)info
{
#if 0
    NSDictionary *userInfo = info[@"user"];
    NSString *imageUrl = userInfo[@"profile_image_url"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    UIImage *image = [UIImage imageWithData:data];
    self.icon.image = image;
    self.name.text = userInfo[@"name"];
    self.time.text = info[@"created_at"];
    self.source.text = info[@"source"];
    self.content.text = info[@"text"];
#endif
    [self.icon sd_setImageWithURL:[NSURL URLWithString:info.user.profile_image_url]];
    self.name.text = info.user.name;
    self.source.text = info.source;
    self.content.text = info.text;
    self.time.text = info.createdString;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
