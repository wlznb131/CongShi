//
//  NSDictionary+CSExtension.h
//  CongShi
//
//  Created by Archy on 16/1/25.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CSExtension)

/**
 *  用于将网络请求返回带有换行空格的json数据转换为字典
 *
 *  @param responseObj 相应参数
 *
 *  @return 转换结果
 */
+ (NSDictionary *)resultWithResponseObj:(id)responseObj;

@end
