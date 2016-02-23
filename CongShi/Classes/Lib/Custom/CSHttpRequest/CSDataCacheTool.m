//
//  CSDataCacheTool.m
//  CongShi
//
//  Created by Archy on 16/1/25.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSDataCacheTool.h"
#import "NSString+MD5.h"
@implementation CSDataCacheTool

+ (void)saveDictionary:(NSDictionary *)dictionary fileName:(NSString *)fileName
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive", [NSString MD5WithString:fileName]]];
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:dictionary toFile:filePath];
    if (flag) {
        CSLog(@"Archive Success");
    }
}

+ (NSDictionary *)dictionaryWithFileName:(NSString *)fileName
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive", [NSString MD5WithString:fileName]]];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


@end
