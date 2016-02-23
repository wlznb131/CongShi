//
//  UIColor+CSCompatibility.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CSCompatibility)

- (BOOL)cs_isCompatibleWithColor:(UIColor *)color;
- (BOOL)cs_isDarkColor;
- (BOOL)cs_isDistinct:(UIColor *)compareColor;
- (BOOL)cs_isBlackOrWhite;
- (BOOL)cs_isContrastingColor:(UIColor *)color;
- (UIColor *)cs_colorWithMinimumSaturation:(CGFloat)saturation;
- (UIColor *)cs_darkerShade;
- (UIColor *)cs_lighterShade;
- (float)brightness;
+ (UIColor *)RandomColor;
+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHexString:(NSString *)hex withAlpha:(CGFloat)alpha;


@end
