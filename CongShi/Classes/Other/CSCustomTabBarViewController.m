//
//  CSCustomTabBarViewController.m
//  CongShi
//
//  Created by Archy on 16/2/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSCustomTabBarViewController.h"
#import "CSMySideViewController.h"

@interface CSCustomTabBarViewController ()

@property (nonatomic, strong) CSMySideViewController* mySide;
@property (nonatomic, assign, getter=isHomePage) BOOL homePage;

@end

@implementation CSCustomTabBarViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTabBarView) name:CLOSE_TABVIEW object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showtabBarView) name:SHOW_TABVIEW object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHome) name:@"home" object:nil];
        self.homePage = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customTabBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = CSBackgroundColor;
}

- (void)customTabBar
{
    NSArray* controllers = @[ @"CSFindViewController", @"CSFavoriteViewController", @"CSTopicViewController", @"CSMySideViewController" ];
    NSMutableArray* viewControllers = [NSMutableArray array];
    for (NSString* controller in controllers) {
        if ([controller isEqualToString:@"CSMySideViewController"]) {
            CSMySideViewController* mySide = [[CSMySideViewController alloc] init];
            [mySide setBgRGB:0xFFFFFF];
            mySide.view.frame = self.view.bounds;
            [self.view addSubview:mySide.view];
            self.mySide = mySide;
        }
        UIViewController* viewController = [[NSClassFromString(controller) alloc] init];
        CSNavigationViewController* navc = [[CSNavigationViewController alloc] initWithRootViewController:viewController];
        viewController.hidesBottomBarWhenPushed = YES;
        [viewControllers addObject:navc];
    }

    self.tabBar.hidden = YES;
    self.viewControllers = viewControllers;
    [self createUI];
}

- (void)createUI
{
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, CSAPP_HEIGHT - 49, CSAPP_HEIGHT, 49)];
    [self.tabBarView setBackgroundColor:[UIColor clearColor]];
    UIVisualEffect* lightBlurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
    UIVisualEffectView* visualeffectview = [[UIVisualEffectView alloc] initWithEffect:lightBlurEffect];
    visualeffectview.frame = self.tabBarView.bounds;
    [self.tabBarView addSubview:visualeffectview];

    [self.view addSubview:self.tabBarView];
    NSArray* imageArray = @[ @"favoriteIconNormal", @"findIconNormal", @"topicIconNormal", @"myIconNormal" ];
    NSArray* selectedImageArray = @[ @"favoriteIconSelected", @"findIconSelected", @"topicIconSelected", @"myIconSelected" ];
    NSArray* labelArray = @[ @"发现", @"推荐", @"分享", @"我" ];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i + 10];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImageArray[i]] forState:UIControlStateSelected];
        [button setFrame:CGRectMake(i * (CSAPP_WIDTH / 4), -7, CSAPP_WIDTH / 4, 50)];
        if (i == 0) {
            button.selected = YES;
        }
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * (CSAPP_WIDTH / 4), 33, 18, 13)];
        label.text = labelArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = CSPFSCRegularFont(9);
        label.textColor = CSLabelColor;
        label.centerX = button.centerX;
        [self.tabBarView addSubview:label];
        [button addTarget:self action:@selector(onChooseVCClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:button];
    }
}

- (void)showHome
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nearVC" object:nil];
    UIButton* button = (UIButton*)[self.tabBarView viewWithTag:10];
    [button setSelected:YES];
    UIButton* sendBtn = (UIButton*)[self.tabBarView viewWithTag:12];
    [sendBtn setSelected:NO];
    self.selectedIndex = 0;
}

- (void)onChooseVCClick:(UIButton*)sender
{
    for (NSInteger i = 0; i < 4; i++) {
        UIButton* button = (UIButton*)[self.tabBarView viewWithTag:i + 10];
        button.selected = NO;
    }

    if (sender.tag != 13) {
        UIButton* button = (UIButton*)[self.tabBarView viewWithTag:sender.tag];
        [button setSelected:YES];
        self.selectedIndex = sender.tag - 10;
    }
    else {
        //        [self closeTabBarView];
        [self.view bringSubviewToFront:self.mySide.view];
        [self.mySide showHideSidebar];
    }
}

- (void)closeTabBarView
{
    self.hidesBottomBarWhenPushed = YES;
    [self.tabBarView setHidden:YES];
}

- (void)showtabBarView
{
    [self.tabBarView setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end