//
//  CSBannerCollectionViewCell.m
//  CongShi
//
//  Created by Archy on 16/1/21.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSBannerCollectionViewCell.h"
#import "CSBannerView.h"
@implementation CSBannerCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    CSBannerView *bannerView = [[CSBannerView alloc] initWithFrame:CGRectMake(0, 0, CSAPP_WIDTH, CSLayoutHeight(360))];
    bannerView.shouldLoop = YES;
    bannerView.autoScroll = YES;
    [self addSubview:bannerView];
    self.bannerView = bannerView;
}

@end
