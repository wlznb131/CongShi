//
//  CSFavoriteBlurView.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSFavoriteBlurView : UIView

@property (nonatomic, strong) UIColor *customColor;

- (instancetype)initWithFrame:(CGRect)frame andCustomColor:(UIColor *)customColor;


@end
