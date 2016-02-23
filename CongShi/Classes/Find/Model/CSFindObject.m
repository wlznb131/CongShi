//
//  CSFindObject.m
//  CongShi
//
//  Created by Archy on 16/1/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSFindObject.h"

@implementation CSFindObject
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"banner":@"CSBannerObject",
             @"hot":@"CSTagObject",
             @"topic":@"CSTopicObject",
             @"course":@"CSCourseObject"
             };
}
@end