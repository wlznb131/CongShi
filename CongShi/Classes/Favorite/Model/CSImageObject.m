//
//  CSImageObject.m
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSImageObject.h"
#import "CSImageColorPicker.h"

@interface CSImageObject()

@property (nonatomic, strong, readwrite) UIColor *backgroundColor;
@property (nonatomic, strong, readwrite) UIColor *primaryColor;
@property (nonatomic, strong, readwrite) UIColor *secondaryColor;
@property (nonatomic, strong, readwrite) UIColor *detailColor;

@end

@implementation CSImageObject

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CSImageColorPicker *picker = [[CSImageColorPicker alloc] initWithImage:image];
    _backgroundColor = picker.backgroundColor;
    _primaryColor = picker.primaryTextColor;
    _secondaryColor = picker.secondaryTextColor;
    _detailColor = picker.detailTextColor;
}

@end
