//
//  NSString+MD5.h
//  Arts1
//
//  Created by apple on 15/9/20.
//  Copyright © 2015年 Arts1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

//MD5先加密，后乱序
+ (NSString *)MD5WithString:(NSString *)str;

@end
