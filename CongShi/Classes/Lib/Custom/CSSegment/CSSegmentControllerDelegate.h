//
//  CSSegmentControllerDelegate.h
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSSegmentControllerDelegate <NSObject>

- (NSString *)segmentTitle;

@optional

- (UIScrollView *)streachScrollView;

@end