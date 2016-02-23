//
//  UIColor+CSCompatibility.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "UIColor+CSCompatibility.h"

const float kCSMinimumIntensityDifference = .35f;

@implementation UIColor (CSCompatibility)

+ (UIColor *)RandomColor
{
    CGFloat r = (arc4random_uniform(181) + 50) * .01;
    CGFloat g = (arc4random_uniform(181) + 50) * .01;
    CGFloat b = (arc4random_uniform(181) + 50) * .01;
    return [UIColor colorWithRed:r green:g blue:b alpha:0.5];
}
+ (UIColor *)colorWithHexString:(NSString *)hex {
    return [UIColor colorWithHexString:hex withAlpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hex withAlpha:(CGFloat)alpha{
    NSString* cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    // if hex string begin with "#"..
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return  [UIColor grayColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString* rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString* gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString* bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    // Scan values
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((CGFloat) r / 255.0f)
                           green:((CGFloat) g / 255.0f)
                            blue:((CGFloat) b / 255.0f)
                           alpha:alpha];
}

- (BOOL)cs_isCompatibleWithColor:(UIColor *)color {
    return fabs([color brightness] - [self brightness]) > kCSMinimumIntensityDifference;
}


- (UIColor *)cs_darkerShade {
    CGFloat newBrightness = [self brightness] - kCSMinimumIntensityDifference;
    if (newBrightness < 0.f) {
        newBrightness = 0.f;
    }
    CGFloat hue, saturation;
    [self getHue:&hue saturation:&saturation brightness:NULL alpha:NULL];
    return [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:1.f];
}

- (UIColor *)cs_lighterShade {
    CGFloat newBrightness = [self brightness] + kCSMinimumIntensityDifference;
    if (newBrightness > 1.f) {
        newBrightness = 1.f;
    }
    CGFloat hue, saturation;
    [self getHue:&hue saturation:&saturation brightness:NULL alpha:NULL];
    return [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:1.f];
}

- (float)brightness {
    CGFloat brightness;
    [self getHue:NULL saturation:NULL brightness:&brightness alpha:NULL];
    return brightness;
}

-(BOOL)cs_isDarkColor
{
    UIColor *convertedColor = self;
    CGFloat r, g, b, a;
    
    [convertedColor getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat lum = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    
    if ( lum < .5 )
    {
        return YES;
    }
    
    return NO;
}


- (BOOL)cs_isDistinct:(UIColor *)compareColor
{
    UIColor *convertedColor = self;
    UIColor *convertedCompareColor = compareColor;
    CGFloat r, g, b, a;
    CGFloat r1, g1, b1, a1;
    
    [convertedColor getRed:&r green:&g blue:&b alpha:&a];
    [convertedCompareColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    
    CGFloat threshold = .25; //.15
    
    if ( fabs(r - r1) > threshold ||
        fabs(g - g1) > threshold ||
        fabs(b - b1) > threshold ||
        fabs(a - a1) > threshold )
    {
        // check for grays, prevent multiple gray colors
        
        if ( fabs(r - g) < .03 && fabs(r - b) < .03 )
        {
            if ( fabs(r1 - g1) < .03 && fabs(r1 - b1) < .03 )
                return NO;
        }
        
        return YES;
    }
    
    return NO;
}


- (UIColor *)cs_colorWithMinimumSaturation:(CGFloat)minSaturation
{
    UIColor *tempColor = self;
    
    if ( tempColor != nil )
    {
        CGFloat hue = 0.0;
        CGFloat saturation = 0.0;
        CGFloat brightness = 0.0;
        CGFloat alpha = 0.0;
        
        [tempColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
        if ( saturation < minSaturation )
        {
            return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
        }
    }
    
    return self;
}


- (BOOL)cs_isBlackOrWhite
{
    UIColor *tempColor = self;
    
    if ( tempColor != nil )
    {
        CGFloat r, g, b, a;
        
        [tempColor getRed:&r green:&g blue:&b alpha:&a];
        
        if ( r > .91 && g > .91 && b > .91 )
            return YES; // white
        
        if ( r < .09 && g < .09 && b < .09 )
            return YES; // black
    }
    
    return NO;
}

-(BOOL)cs_isContrastingColor:(UIColor *)color
{
    UIColor *backgroundColor = self;
    UIColor *foregroundColor = color;
    
    if ( backgroundColor != nil && foregroundColor != nil )
    {
        CGFloat br, bg, bb, ba;
        CGFloat fr, fg, fb, fa;
        
        [backgroundColor getRed:&br green:&bg blue:&bb alpha:&ba];
        [foregroundColor getRed:&fr green:&fg blue:&fb alpha:&fa];
        
        CGFloat bLum = 0.2126 * br + 0.7152 * bg + 0.0722 * bb;
        CGFloat fLum = 0.2126 * fr + 0.7152 * fg + 0.0722 * fb;
        
        CGFloat contrast = 0.;
        
        if ( bLum > fLum )
            contrast = (bLum + 0.05) / (fLum + 0.05);
        else
            contrast = (fLum + 0.05) / (bLum + 0.05);
        
        //return contrast > 3.0; //3-4.5 W3C recommends 3:1 ratio, but that filters too many colors
        return contrast > 1.6;
    }
    
    return YES;
}


@end
