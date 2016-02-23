//
//  NSString+MD5.m
//  Arts1
//
//  Created by apple on 15/9/20.
//  Copyright © 2015年 Arts1. All rights reserved.
//

#import "NSString+MD5.h"
#import "NSString+Hash.h"

@implementation NSString (MD5)

//MD5先加密，后乱序
+ (NSString *)MD5WithString:(NSString *)str
{
    //MD5加密
    NSString *pwd = [str md5String];
    //先加密，再把前两位字符添加到后面
    //第一遍的密码
    NSString *pwdPrefix = [pwd substringFromIndex:2];
    NSString *pwdSubfix = [pwd substringToIndex:2];
    //乱序后
    NSString *pwdResult = [pwdPrefix stringByAppendingString:pwdSubfix];
    
    return pwdResult;
}

@end
