//
//  CSColorCube.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSColorCube : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *colors;
- (void)addColor:(UIColor *)color;
- (UIColor *)meanColor;

@end
