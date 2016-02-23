//
//  CSTopicCollectionViewCell.m
//  CongShi
//
//  Created by Archy on 16/1/21.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSTopicCollectionViewCell.h"

@implementation CSTopicCollectionViewCell

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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CSAPP_WIDTH, CSLayoutHeight(90))];
    [self addSubview:imageView];
    [imageView setContentMode:(UIViewContentModeScaleAspectFill)];
    imageView.layer.masksToBounds = YES;
    self.topicImage = imageView;
    
    UILabel *titleLabel = [UILabel newlabelWithAlignment:NSTextAlignmentLeft textColor:CSLabelColor andFont:CSPFSCLightFont(16)];
    [self.topicImage addSubview:titleLabel];
    [titleLabel setFrame:CGRectMake(25, self.bounds.size.height / 2 - 20, self.bounds.size.width - 25, 20)];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.titleLabel = titleLabel;
    
    UILabel *describeLabel = [UILabel newlabelWithAlignment:NSTextAlignmentLeft textColor:CSLabelColor andFont:CSPFSCLightFont(14)];
    [self.topicImage addSubview:describeLabel];
    [describeLabel setFrame:CGRectMake(25, self.bounds.size.height / 2 + 5, self.bounds.size.width - 25, 20)];
    describeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.describeLabel = describeLabel;
    
    
}


@end
