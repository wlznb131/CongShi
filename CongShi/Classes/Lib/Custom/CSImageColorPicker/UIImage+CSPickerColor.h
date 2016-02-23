//
//  UIImage+CSPickerColor.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CSPickerColor)


- (UIColor *)averageColor;
- (UIColor *)backgroundColor;
- (UIColor *)headerAverageColor;
- (UIColor *)footerAverageColor;
- (UIColor *)primaryColorFromBackgroundColor:(UIColor *)backgroundColor;
- (UIColor *)secondaryColorFromBackgroundColor:(UIColor *)backgroundColor primaryColor:(UIColor *)primaryColor;
- (UIColor *)detailColorFromBackgroundColor:(UIColor *)backgroundColor primaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor;
- (UIColor *)lighterColorForColor:(UIColor *)sourceColor;
- (NSArray *)primaryColors;
- (NSArray *)imageColors;


@end
