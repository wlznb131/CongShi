//
//  CSHotCollectionViewCell.m
//  CongShi
//
//  Created by Archy on 16/1/21.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSHotCollectionViewCell.h"

@implementation CSHotCollectionViewCell

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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (CSAPP_WIDTH - 2)/3.0, (CSAPP_WIDTH - 2)/3.0)];
    [self addSubview:imageView];
    [imageView setContentMode:(UIViewContentModeScaleAspectFill)];
    imageView.layer.masksToBounds = YES;
    self.hotImage = imageView;
    
//    UILabel *label = [UILabel newlabelWithAlignment:NSTextAlignmentCenter textColor:CSLabelColor andFont:CSPFSCLightFont(16)];
    UILabel *label = [UILabel newlabelWithAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] andFont:CSPFSCLightFont(16)];

    [label setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [label setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:label];
    self.hotLabel = label;
}
@end
