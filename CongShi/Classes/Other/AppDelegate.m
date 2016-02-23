//
//  AppDelegate.m
//  CongShi
//
//  Created by Archy on 16/1/8.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "AppDelegate.h"
#import "CSTabBarViewController.h"
#import "CSTagCloudViewController.h"
#import "CSCustomTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [CSCommonDefault SetUserDefault:@"isLogin" byBool:NO];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    CSCustomTabBarViewController *tabBarVC = [[CSCustomTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];

    [WXApi registerApp:@"wx2f71b85865ba8c88" withDescription:@"congshi"];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp {
    SendAuthResp *authResp = (SendAuthResp *)resp;
    NSDictionary *codeDic = @{@"code":authResp.code};
    CSLog(@"%@",authResp.code);
    
    [CSHttpTool post:WEIXIN_URL params:codeDic success:^(id responseObj) {
        [CSCommonDefault SetUserDefault:@"isLogin" byBool:YES];
        [CSCommonDefault SetUserDefault:@"uid" byValue:responseObj[@"uid"]];
        [CSCommonDefault SetUserDefault:@"token" byValue:responseObj[@"token"]];
        [CSCommonDefault SetUserDefault:@"identity" byValue:responseObj[@"identity"]];
    } failure:^(id error) {
    }];
    

}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
