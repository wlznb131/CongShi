//
//  CSDataCacheTool.h
//  CongShi
//
//  Created by Archy on 16/1/25.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSDataCacheTool : NSObject

/**
 *  存储字典数据
 *
 *  @param dictionary 字典数据
 *  @param fileName   文件名
 */
+ (void)saveDictionary:(NSDictionary *)dictionary fileName:(NSString *)fileName;

/**
 *  取字典数据
 *
 *  @param fileName 文件名
 *
 *  @return 字典数据
 */
+ (NSDictionary *)dictionaryWithFileName:(NSString *)fileName;


@end
