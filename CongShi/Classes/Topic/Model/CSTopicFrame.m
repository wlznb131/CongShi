//
//  CSTopicFrame.m
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSTopicFrame.h"
#import "CSTopicStatus.h"

CGFloat const kVerticalPadding = 20;
CGFloat const kHorizontalPadding = 15;

@implementation CSTopicFrame

- (void)setStatus:(CSTopicStatus *)status
{
    _status = status;
    /**头像的框架*/
    _headF = CGRectMake(kHorizontalPadding, kVerticalPadding, 40, 40);
    /**姓名的框架*/
    CGFloat nameX = GetMaxX(_headF) + kHorizontalPadding;
    CGFloat nameY = kVerticalPadding;
    CGSize nameS = CGSizeZero;
    if (status.wechat_nickname) {
        nameS = [status.wechat_nickname sizeWithHeight:20 andFont:CSPFSCRegularFont(14)];
    } else {
        nameS = [status.nickName sizeWithHeight:20 andFont:CSPFSCRegularFont(14)];
    }
    _nameF = CGRectMake(nameX, nameY, nameS.width, nameS.height);
    /**时间的框架*/
    CGSize timeS = [status.addTime sizeWithHeight:14 andFont:CSPFSCRegularFont(10)];
    CGFloat timeX = CSAPP_WIDTH - timeS.width - kHorizontalPadding;
    CGFloat timeY = kVerticalPadding;
    _timeF = CGRectMake(timeX, timeY, timeS.width, timeS.height);
    /**博文的框架*/
    CGFloat blogW = CSAPP_WIDTH - 3 * kHorizontalPadding - 40;
    CGSize blogS = [status.content sizeWithWidth:blogW andFont:CSPFSCThinFont(13) andLineSpaceing:20];
    CGFloat blogX = nameX;
    CGFloat blogY = GetMaxY(_nameF) ;
    _blogF = CGRectMake(blogX, blogY, blogW, blogS.height);
    /**配图的框架*/
    if (status.photolist) {
        CGFloat imageX = nameX;
        CGFloat imageY = GetMaxY(_blogF) ;
        CGFloat imageW = _blogF.size.width;
        CGFloat imageH = imageW * (175 / 290.0);
        _imageF = CGRectMake(imageX, imageY, imageW, imageH);
    } else {
        _imageF = CGRectZero;
    }
    /**参数的框架*/
    CGFloat tipW = 60;
    CGFloat tipH = 21;
    CGFloat tipY = 0;
    if (status.photolist) {
        tipY = GetMaxY(_imageF) + kVerticalPadding;
    } else {
        tipY = GetMaxY(_blogF) + kVerticalPadding;
    }
    _likeF = CGRectMake(nameX, tipY, tipW, tipH);
    _commentF = CGRectMake(nameX, tipY, tipW, tipH);
    _shareF = CGRectMake(nameX, tipY, tipW, tipH);
    
    _cellHeight = GetMaxY(_likeF) + kVerticalPadding;
}

@end
