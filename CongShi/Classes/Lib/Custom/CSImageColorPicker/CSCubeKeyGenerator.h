//
//  CSCubeKeyGenerator.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef struct {
    CGFloat a, b, c;
}CSFloatTriple;

@interface CSCubeKeyGenerator : NSObject

+ (instancetype)keyGeneratorWithGranularity:(NSUInteger)numberOfPartitions;

- (NSString *)keyForTriple:(CSFloatTriple)triple;

@end
