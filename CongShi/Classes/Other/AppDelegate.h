//
//  AppDelegate.h
//  CongShi
//
//  Created by Archy on 16/1/8.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

