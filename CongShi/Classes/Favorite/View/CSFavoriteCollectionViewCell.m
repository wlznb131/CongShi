//
//  CSFavoriteCollectionViewCell.m
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSFavoriteCollectionViewCell.h"

CGFloat const ImageHeight = 350;
CGFloat const ImageOffsetSpeed = 35;

@interface CSFavoriteCollectionViewCell()

@property (nonatomic, strong) UIImageView *favoriteImageView;

@end

@implementation CSFavoriteCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI
{
    self.clipsToBounds = YES;
    
    UIImageView *favoriteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, ImageHeight)];
    favoriteImageView.backgroundColor = [UIColor clearColor];
    favoriteImageView.contentMode = UIViewContentModeScaleAspectFill;
    favoriteImageView.clipsToBounds = NO;
    [self.contentView addSubview:favoriteImageView];
    self.favoriteImageView = favoriteImageView;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, self.bounds.size.width, 30)];
    nameLabel.font = CSPFSCRegularFont(16);
    nameLabel.text = @"Text";
    [self.contentView addSubview:nameLabel];
    self.favoriteName = nameLabel;
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 290, self.bounds.size.width, 30)];
    descriptionLabel.font = CSPFSCRegularFont(16);
    descriptionLabel.text = @"SUBTITLE TEXT OF EATIT";
    [self.contentView addSubview:descriptionLabel];
    self.favoriteDescription = descriptionLabel;
}

- (void)setFavoriteImage:(UIImage *)favoriteImage
{
    self.favoriteImageView.image = favoriteImage;
    [self setImageOffset:self.imageOffset];
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    _imageOffset =imageOffset;
    
    CGRect frame = self.favoriteImageView.bounds;
    CGRect offsetFrame = CGRectOffset(frame, _imageOffset.x, _imageOffset.y);
    
    self.favoriteImageView.frame = offsetFrame;
}

@end
