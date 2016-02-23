//
//  NSDictionary+CSExtension.m
//  CongShi
//
//  Created by Archy on 16/1/25.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "NSDictionary+CSExtension.h"

@implementation NSDictionary (CSExtension)

+ (NSDictionary *)resultWithResponseObj:(id)responseObj
{
    NSData *data = responseObj;
    
    NSMutableString *json = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] mutableCopy];
    //去掉首尾空格和换行
    json = [[json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    
    NSRange range = {0,json.length};
    [json replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSLiteralSearch range:range];//转义换行
    NSRange range1 = {0, json.length};
    [json replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSLiteralSearch range:range1];//转义换行
    NSRange range2 = {0, json.length};
    [json replaceOccurrencesOfString:@"\t" withString:@" " options:NSLiteralSearch range:range2];//转义空格
    NSData *result = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        CSLog(@"json解析---error----%@", error.description);
    }
    return response;
}


@end
