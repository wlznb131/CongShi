//
//  CSColorSorter.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSColorSorter : NSObject

+ (instancetype)colorSorterWithGranularity:(NSUInteger)numberOfPartitions;

- (NSArray *)sortColors:(NSArray *)colors;

@end
