//
//  CSTopicStatus.h
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTopicStatus : NSObject

//Id 说说id
//userId 用户id
//photolist 图片链接数组
//content 文字内容
//goods 赞数
//comments 评论数
//addTime 发表时间
//userFace 用户头像
//wechat_headimg 微信头像
//wechat_nickname 微信昵称
//gender 性别
//Province 省份
//City 城市
//nickName 昵称
//addTime 关注时间
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userFace;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *photolist;
@property (nonatomic, assign) NSInteger goods;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger share;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *Province;
@property (nonatomic, strong) NSString *City;
@property (nonatomic, strong) NSString *wechat_headimg;
@property (nonatomic, strong) NSString *wechat_nickname;

@end
