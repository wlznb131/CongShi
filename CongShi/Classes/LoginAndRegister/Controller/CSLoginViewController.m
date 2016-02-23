//
//  CSLoginViewController.m
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSLoginViewController.h"
#import "CSTagCloudViewController.h"
#import "CSTabBarViewController.h"
#import "WXApiManager.h"
#import "WXApiRequestHandler.h"

@interface CSLoginViewController ()<WXApiManagerDelegate>

@property (nonatomic, strong) UIVisualEffectView *visualeffectview;

@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  ssssss
    [self configUI];
    [WXApiManager sharedManager].delegate = self;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([CSCommonDefault GetUserDefaultBool:@"isLogin"]) {
        CSTagCloudViewController *tag = [[CSTagCloudViewController alloc] init];
        [self presentViewController:tag animated:YES completion:nil];
    }

}

- (void)configUI
{
    [self createVisualEffectView];

    UIImageView* loginView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 63, 52)];
    loginView.image = [[UIImage imageNamed:@"Fill 2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    loginView.centerX = self.view.centerX;
    loginView.top = CSLayoutHeight(237);
    [loginView addTapAction:@selector(login) target:self];

    CSCustomBackButton* backButton = [[CSCustomBackButton alloc] initWithFrame:CGRectMake(15, 15, 25, 25)];
    backButton.customColor = [UIColor whiteColor];
    [backButton addTarget:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    UILabel* loginLabel = [UILabel newlabelWithAlignment:NSTextAlignmentCenter textColor:CSLabelColor andFont:CSPFSCLightFont(24)];
    loginLabel.size = CGSizeMake(116, 34);
    loginLabel.text = @"微信登陆";
    loginLabel.centerX = loginView.centerX;
    loginLabel.top = loginView.bottom + 10;
    [loginLabel addTapAction:@selector(login) target:self];

    UILabel* dashiLoginLabel = [UILabel newLabelWithFrame:CGRectMake(0, 0, 84, 20) alignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] andFont:CSPFSCMediumFont(14)];
    dashiLoginLabel.centerX = self.view.centerX;
    dashiLoginLabel.top = CSLayoutHeight(491);
    dashiLoginLabel.text = @"注册名师登录";
    [dashiLoginLabel addTapAction:@selector(dashiLogin) target:self];

    [self.view addSubview:dashiLoginLabel];
    [self.view addSubview:loginLabel];
    [self.view addSubview:loginView];
}

- (void)dashiLogin
{
    CSTabBarViewController *tabBar = [[CSTabBarViewController alloc] init];
    [self presentViewController:tabBar animated:YES completion:nil];
}

- (void)backToRoot
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)login
{
    [WXApiRequestHandler sendAuthRequestScope:@"snsapi_userinfo" State:@"xxx" OpenID:@"wx2f71b85865ba8c88" InViewController:self];
}
//  微信授权返回结果
//- (void)managerDidRecvAuthResponse:(SendAuthResp *)response
//{
//    [CSCommonDefault SetUserDefault:@"isLogin" byBool:YES];
//    if(response.code){
//        NSDictionary *codeDic = @{@"code":response.code};
//        NSLog(@"%@",response.code);
//    }
//
//    
//}
//


- (void)createVisualEffectView{
    UIVisualEffect *lightBlurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
    _visualeffectview = [[UIVisualEffectView alloc] initWithEffect:lightBlurEffect];
    _visualeffectview.frame = CGRectMake(0, 0, CSAPP_WIDTH , CSAPP_HEIGHT);
    
    [self.view addSubview:_visualeffectview];
}

@end
