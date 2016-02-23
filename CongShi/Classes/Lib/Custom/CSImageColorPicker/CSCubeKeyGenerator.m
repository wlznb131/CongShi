//
//  CSCubeKeyGenerator.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSCubeKeyGenerator.h"

@interface CSCubeKeyGenerator()

@property (nonatomic, assign) NSInteger granularity;

@end

@implementation CSCubeKeyGenerator

+ (instancetype)keyGeneratorWithGranularity:(NSUInteger)numberOfPartitions {
    CSCubeKeyGenerator *generator = [CSCubeKeyGenerator new];
    generator.granularity = numberOfPartitions;
    return generator;
}

- (NSString *)keyForTriple:(CSFloatTriple)triple {
    NSParameterAssert(self.granularity);
    return [NSString stringWithFormat:@"%@-%@-%@", [self paddedStringForValue:triple.a],
            [self paddedStringForValue:triple.b],
            [self paddedStringForValue:triple.c]];
}

- (NSString *)paddedStringForValue:(float)value {
    NSUInteger partitionNumber = floorf(value * self.granularity);
    NSUInteger paddingWidth = [[NSString stringWithFormat:@"%ld", (long)self.granularity] length];
    return [NSString stringWithFormat:@"%0*lu", (int)paddingWidth, (unsigned long)partitionNumber];
}


@end
