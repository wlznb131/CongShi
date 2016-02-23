//
//  CSTabBarViewController.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSTabBarViewController.h"
#import "CSNavigationViewController.h"
#import "CSFavoriteViewController.h"
#import "CSFindViewController.h"
#import "CSMyViewController.h"
#import "CSTopicViewController.h"


@interface CSTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarItem *myItem;

@end

@implementation CSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewControllersInit];
    self.tabBar.hidden = YES;
    self.selectedIndex = 0-2;
}

- (void)configUI
{
}

- (void)viewControllersInit
{
    /**初始化推荐页面*/
    CSFavoriteViewController *favoriteVC = [[CSFavoriteViewController alloc] init];
    CSNavigationViewController *navFav =  [[CSNavigationViewController alloc] initWithRootViewController:favoriteVC];
    navFav.tabBarItem.title = @"推荐";
    navFav.tabBarItem.image = [[UIImage imageNamed:@"favoriteIconNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFav.tabBarItem.selectedImage = [[UIImage imageNamed:@"favoriteIconSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    /**初始化发现页面*/
    CSFindViewController *findVC = [[CSFindViewController alloc] init];
    CSNavigationViewController *navFind =  [[CSNavigationViewController alloc] initWithRootViewController:findVC];
    navFind.tabBarItem.title = @"发现";
    navFind.tabBarItem.image = [[UIImage imageNamed:@"findIconNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navFind.tabBarItem.selectedImage = [[UIImage imageNamed:@"findIconSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    /**初始化话题页面*/
    CSTopicViewController *topicVC = [[CSTopicViewController alloc] init];
    CSNavigationViewController *navTopic = [[CSNavigationViewController alloc] initWithRootViewController:topicVC];
    navTopic.tabBarItem.title = @"话题";
    navTopic.tabBarItem.image = [[UIImage imageNamed:@"topicIconNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navTopic.tabBarItem.selectedImage = [[UIImage imageNamed:@"topicIconSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    /**初始化我页面*/
    CSMyViewController *myVC = [[CSMyViewController alloc] init];
    CSNavigationViewController *navMy =  [[CSNavigationViewController alloc] initWithRootViewController:myVC];
    navMy.tabBarItem.title = @"我";
    navMy.tabBarItem.image = [[UIImage imageNamed:@"myIconNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navMy.tabBarItem.selectedImage = [[UIImage imageNamed:@"myIconSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.myItem = navMy.tabBarItem;
    self.tabBar.tintColor = [UIColor lightGrayColor];
    self.tabBar.barStyle = UIBarStyleBlack;
    self.viewControllers = @[navFind,navFav,navTopic,navMy];
    
    self.tabBarController.delegate = self;

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item isEqual:self.myItem]) {
        NSLog(@"123");
    }
}



@end
