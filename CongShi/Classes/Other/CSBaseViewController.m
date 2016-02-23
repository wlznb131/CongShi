//
//  CSBaseViewController.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSCustomTabBarViewController.h"

#define kTabBarY [UIScreen mainScreen].bounds.size.height - 49.0

@interface CSBaseViewController ()<UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isScrollToDown;

@end

@implementation CSBaseViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float newY = 0;
    static float oldY = 0;
    oldY = newY;
    newY = scrollView.contentOffset.y;
    CSCustomTabBarViewController *tabBarController = (CSCustomTabBarViewController *)self.tabBarController;
    if (scrollView.contentOffset.y > 0) {
        if (newY != oldY) {
            if (newY > oldY)
            {
                if (tabBarController.tabBarView.y < CSAPP_HEIGHT) {
                    tabBarController.tabBarView.y += 1;
                }
                tabBarController.tabBarView.y += 0;
                self.isScrollToDown = YES;
            }
            else if (newY < oldY)
            {
                if (tabBarController.tabBarView.y > kTabBarY) {
                    tabBarController.tabBarView.y -= 1;
                }
                tabBarController.tabBarView.y -= 0;
                self.isScrollToDown = NO;
            }
        }
    } else {
        tabBarController.tabBarView.y = kTabBarY;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self tabBarMoveWhenEndScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self tabBarMoveWhenEndScroll];
}

- (void)tabBarMoveWhenEndScroll
{
    CSCustomTabBarViewController *tabBarController = (CSCustomTabBarViewController *)self.tabBarController;
    if (self.isScrollToDown)
    {
        if (tabBarController.tabBarView.y > (kTabBarY + (49 /5.0))) {
            [UIView animateWithDuration:0.5 animations:^{
                tabBarController.tabBarView.y = CSAPP_HEIGHT;
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                tabBarController.tabBarView.y = CSAPP_HEIGHT - 49;
            }];
        }
    }
    else
    {
        if (self.tabBarController.tabBar.y < (CSAPP_HEIGHT - (49/5.0))) {
            [UIView animateWithDuration:0.5 animations:^{
                tabBarController.tabBarView.y = CSAPP_HEIGHT - 49;
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                tabBarController.tabBarView.y = CSAPP_HEIGHT;
            }];
        }
    }
}

@end
