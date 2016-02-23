//
//  CSCustomTabBarViewController.h
//  CongShi
//
//  Created by Archy on 16/2/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSCustomTabBarViewController : UITabBarController

@property (nonatomic, strong) UIView       *tabBarView;

- (void)closeTabBarView;

- (void)showtabBarView;

@end
