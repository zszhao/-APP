//
//  Header.h
//  微博测试版APP
//
//  Created by qingyun on 15/11/10.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#ifndef _____APP_Header_h
#define _____APP_Header_h
#define kAppKey @"1772495450"
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define kAppSecret @"981b9cc769fd234d51b96d1b7cea9933"
#define kAccountFileName @"accountInfo"
#define kLogoutNotification @"kLogoutNotification"
#define kLoginNotification @"kLoginNotification"
#define kStatusFileName @"kStatusFileName"
#define kStatusTableName @"status"
//解析微博所使用的关键字常量，也就是新浪服务器返回的数据由JSONKit解析后生成的字典关于微博信息的key值
static NSString * const kStatusCreateTime = @"created_at";
static NSString * const kStatusID = @"id";
static NSString * const kStatusMID = @"mid";
static NSString * const kStatusText = @"text";
static NSString * const kStatusSource = @"source";
static NSString * const kStatusThumbnailPic = @"thumbnail_pic";
static NSString * const kStatusOriginalPic = @"original_pic";
static NSString * const kStatusPicUrls = @"pic_urls";
static NSString * const kStatusRetweetStatus = @"retweeted_status";
static NSString * const kStatusUserInfo = @"user";
static NSString * const kStatusRetweetStatusID = @"retweeted_status_id";
static NSString * const kStatusRepostsCount = @"reposts_count";
static NSString * const kStatusCommentsCount = @"comments_count";
static NSString * const kStatusAttitudesCount = @"attitudes_count";
static NSString * const kstatusFavorited = @"favorited";

//解析微博用户数据所使用的关键字常量，也就是新浪服务器返回的数据由JSONKit解后生成的字典关于用户信息的Key值。
static NSString * const kUserInfoScreenName = @"screen_name";
static NSString * const kUserInfoName = @"name";
static NSString * const kUserAvatarLarge = @"avatar_large";
static NSString * const kUserAvatarHd = @"avatar_hd";
static NSString * const kUserID = @"id";
static NSString * const kUserDescription = @"description";
static NSString * const kUserVerifiedReson = @"verified_reason";
static NSString * const kUserFollowersCount = @"followers_count";
static NSString * const kUserStatusCount = @"statuses_count";
static NSString * const kUserFriendCount = @"friends_count";
static NSString * const kUserStatusInfo = @"status";
static NSString * const kUserStatuses = @"statuses";
static NSString * const kUserProfileImageURL = @"profile_image_url";


#endif
