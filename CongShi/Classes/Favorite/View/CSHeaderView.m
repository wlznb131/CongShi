//
//  CSHeaderView.m
//  CongShi
//
//  Created by Archy on 15/12/31.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSFavoriteBlurView.h"
#import "CSHeaderView.h"

@interface CSHeaderView ()

@end

@implementation CSHeaderView

- (void)awakeFromNib
{
    [self configUI];
}

- (void)configUI
{
    self.headAttention.layer.borderWidth = 1;
    self.headAttention.layer.cornerRadius = 10;
    self.blurView.opaque = NO;

    self.bluredImageView = [[UIImageView alloc] initWithFrame:self.frame];
    self.bluredImageView.autoresizingMask = self.autoresizingMask;
    self.bluredImageView.alpha = 0.0f;
    [self insertSubview:self.bluredImageView aboveSubview:self.headImage];

    [self refreshBlurViewForNewImage];
}

- (void)refreshBlurViewForNewImage
{
    UIImage* screenShot = [self screenShotOfView:self];
    screenShot = [screenShot applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.6 alpha:0.2] saturationDeltaFactor:1.0 maskImage:nil];
    self.bluredImageView.image = screenShot;
}

- (UIImage*)screenShotOfView:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 0.0);
    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
