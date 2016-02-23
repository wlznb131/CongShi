//
//  CSFavoriteCollectionViewCell.h
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const ImageHeight;
extern CGFloat const ImageOffsetSpeed;

@interface CSFavoriteCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *favoriteImage;

@property (nonatomic, strong) UILabel *favoriteName;

@property (nonatomic, strong) UILabel *favoriteDescription;

@property (nonatomic, assign) CGPoint imageOffset;

@end
