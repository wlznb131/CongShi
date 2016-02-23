//
//  CSCommonDefault.m
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSCommonDefault.h"

@implementation CSCommonDefault

+ (void)SetUserDefault:(NSString *)key byValue:(id)value {
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

+ (void)SetUserDefault:(NSString *)key byBool:(BOOL)show {
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)DeleteUserDefault:(NSString *)key {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

+ (id)GetUserDefault:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
}

+ (BOOL)GetUserDefaultBool:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


@end
