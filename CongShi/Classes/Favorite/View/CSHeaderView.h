//
//  CSHeaderView.h
//  CongShi
//
//  Created by Archy on 15/12/31.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSFavoriteBlurView;
@interface CSHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *headName;
@property (weak, nonatomic) IBOutlet UILabel *headDescription;
@property (weak, nonatomic) IBOutlet UIButton *headAttention;
@property (weak, nonatomic) IBOutlet CSFavoriteBlurView *blurView;
@property (strong, nonatomic)  UIImageView *bluredImageView;

@end
