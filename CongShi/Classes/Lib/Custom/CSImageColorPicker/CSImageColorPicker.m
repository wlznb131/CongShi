//
//  CSImageColorPicker.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSImageColorPicker.h"
#import "UIImage+CSPickerColor.h"

@interface CSImageColorPicker()

@property (nonatomic, readwrite) UIColor        *backgroundColor;
@property (nonatomic, readwrite) UIColor        *primaryTextColor;
@property (nonatomic, readwrite) UIColor        *secondaryTextColor;
@property (nonatomic, readwrite) UIColor        *detailTextColor;

@end

@implementation CSImageColorPicker

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.primaryTextColor = [UIColor whiteColor];
        self.secondaryTextColor = [UIColor lightGrayColor];
        self.detailTextColor = [UIColor lightGrayColor];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
        
        NSArray *array = [image primaryColors];
        self.backgroundColor = [image backgroundColor];
        self.primaryTextColor = [array objectAtIndex:0];
        self.secondaryTextColor = [array objectAtIndex:1];
        self.detailTextColor = [array objectAtIndex:2];
    }
}

@end
