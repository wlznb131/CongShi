//
//  CSColorSorter.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSColorSorter.h"
#import "CSColorCube.h"
#import "CSCubeKeyGenerator.h"

@interface CSColorSorter()

@property (nonatomic, strong) CSCubeKeyGenerator *keyGenerator;

@end

@implementation CSColorSorter

+ (instancetype)colorSorterWithGranularity:(NSUInteger)numberOfPartitions {
    CSColorSorter *sorter = [CSColorSorter new];
    sorter.keyGenerator = [CSCubeKeyGenerator keyGeneratorWithGranularity:numberOfPartitions];
    return sorter;
}

- (NSArray *)sortColors:(NSArray *)colors {
    NSParameterAssert(self.keyGenerator);
    if (!colors) {
        return nil;
    }
    NSMutableDictionary *cubes = [NSMutableDictionary new];
    CSFloatTriple rgb;
    CSColorCube *cube;
    for (UIColor *color in colors) {
        if (![color isKindOfClass:[UIColor class]]) {
            continue;
        }
        [color getRed:&rgb.a green:&rgb.b blue:&rgb.c alpha:NULL];
        NSString *key = [self.keyGenerator keyForTriple:rgb];
        cube = cubes[key];
        if (!cube) {
            cube = [[CSColorCube alloc] init];
            cubes[key] = cube;
        }
        [cube addColor:color];
    }
    
    NSArray *fullCubes = [cubes allValues];
    fullCubes = [fullCubes sortedArrayUsingComparator:^NSComparisonResult(CSColorCube *cube1, CSColorCube *cube2) {
        NSNumber *count1 = [NSNumber numberWithInteger:[cube1.colors count]];
        NSNumber *count2 = [NSNumber numberWithInteger:[cube2.colors count]];
        return [count2 compare:count1];
    }];
    
    NSMutableArray *sortedColors = [NSMutableArray new];
    for (CSColorCube *cube in fullCubes) {
        [sortedColors addObject:[cube meanColor]];
    }
    
    return sortedColors;
}


@end
