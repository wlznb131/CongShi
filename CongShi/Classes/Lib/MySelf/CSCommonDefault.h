//
//  CSCommonDefault.h
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCommonDefault : NSObject

+ (void)SetUserDefault:(NSString *)key byValue:(id)value;

+ (void)SetUserDefault:(NSString *)key byBool:(BOOL)show;

+ (void)DeleteUserDefault:(NSString *)key;

+ (id)GetUserDefault:(NSString *)key;

+ (BOOL)GetUserDefaultBool:(NSString *)key;


@end
