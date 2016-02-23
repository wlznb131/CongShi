//
//  CSImageColorPicker.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSImageColorPicker : NSObject

@property (nonatomic, strong) UIImage                           *image;

// You can observing this properties
@property (nonatomic, readonly) UIColor                         *backgroundColor;
@property (nonatomic, readonly) UIColor                         *primaryTextColor;
@property (nonatomic, readonly) UIColor                         *secondaryTextColor;
@property (nonatomic, readonly) UIColor                         *detailTextColor;

- (id)initWithImage:(UIImage *)image;

@end
