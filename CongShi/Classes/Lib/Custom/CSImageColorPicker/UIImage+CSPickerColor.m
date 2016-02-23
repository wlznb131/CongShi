//
//  UIImage+CSPickerColor.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "UIImage+CSPickerColor.h"
#import "UIColor+CSCompatibility.h"
#import "CSColorSorter.h"

const float selectionColorPointCount        = 144.0f;

@implementation UIImage (CSPickerColor)

- (NSArray *)getColorArrayWithCount:(int)count {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [self CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    const int wCount = (int) sqrt(count);
    const int hCount = (int) count / wCount;
    
    const int numColumnInMetering = (int) width / (wCount + 2);
    const int numRowInMetering = (int) height / (hCount + 2);
    
    for (int i=0; i<=wCount; i++) {
        for (int j=0; j<=hCount; j++) {
            int x = numColumnInMetering + (numColumnInMetering * i);
            int y = numRowInMetering + (numRowInMetering * j);
            int byteIndex = (int)((bytesPerRow * y) + (bytesPerPixel * x));
            
            CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
            CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
            CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
            CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
            
            UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
            [result addObject:acolor];
        }
    }
    free(rawData);
    return result;
}

- (UIImage *)getSubImageWithRect:(CGRect)rect {
    CGImageRef drawImage = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *newImage = [UIImage imageWithCGImage:drawImage];
    CGImageRelease(drawImage);
    return newImage;
}

- (float)squareDistanceInRGBSpaceBetweenColorA:(UIColor *)colorA colorB:(UIColor *)colorB {
    
    const CGFloat *componentsA = CGColorGetComponents(colorA.CGColor);
    CGFloat redA = componentsA[0];
    CGFloat greenA = componentsA[1];
    CGFloat blueA = componentsA[2];
    
    const CGFloat *componentsB = CGColorGetComponents(colorB.CGColor);
    CGFloat redB = componentsB[0];
    CGFloat greenB = componentsB[1];
    CGFloat blueB = componentsB[2];
    
    float squareDistance = ((redA - redB) * (redA - redB)) +
    ((greenA - greenB) * (greenA - greenB)) +
    ((blueA - blueB) * (blueA - blueB));
    return squareDistance;
}

- (UIColor *)getImprovedColorFromColor:(UIColor *)colorA backgroundColor:(UIColor *)colorB {
    
    const CGFloat *componentsA = CGColorGetComponents(colorA.CGColor);
    CGFloat redA = componentsA[0];
    CGFloat greenA = componentsA[1];
    CGFloat blueA = componentsA[2];
    
    const CGFloat *componentsB = CGColorGetComponents(colorB.CGColor);
    CGFloat redB = componentsB[0];
    CGFloat greenB = componentsB[1];
    CGFloat blueB = componentsB[2];
    
    const CGFloat coef = .5f;
    UIColor *improvedColor = [UIColor colorWithRed:redA + (redA - redB) * coef
                                             green:greenA + (greenA - greenB) * coef
                                              blue:blueA + (blueA - blueB) * coef
                                             alpha:1.f];
    return improvedColor;
}

- (UIColor *)averageColor {
    return [self averageColorForImage:self];
}
- (UIColor *)backgroundColor
{
    return [[self imageColors] objectAtIndex:0];
}

- (UIColor *)defaultPrimaryColor {
    UIColor *backgroundColor = [self backgroundColor];
    return [backgroundColor brightness] > 0.5 ?
    [[backgroundColor cs_darkerShade] cs_lighterShade] :
    [[backgroundColor cs_lighterShade] cs_darkerShade];
}

- (UIColor *)defaultSecondaryColor {
    
    UIColor *backgroundColor = [self backgroundColor];
    return [backgroundColor brightness] > 0.5 ?
    [backgroundColor cs_darkerShade] : [backgroundColor cs_lighterShade];
}

- (UIColor *)defaultDetailColor {
    
    UIColor *backgroundColor = [self backgroundColor];
    return [backgroundColor brightness] > 0.5? [backgroundColor cs_lighterShade] : [backgroundColor cs_darkerShade];
}


- (UIColor *)headerAverageColor {
    CGRect subImageRect = CGRectMake(self.size.width * .9f, .0f, self.size.width * .1f, self.size.height * .1f);
    return [self averageColorForImage:[self getSubImageWithRect:subImageRect]];
}

- (UIColor *)footerAverageColor {
    CGRect subImageRect = CGRectMake(self.size.width * .9f, self.size.height * .9f, self.size.width * .1f, self.size.height * .1f);
    return [self averageColorForImage:[self getSubImageWithRect:subImageRect]];
}


- (UIColor *)averageColorForImage:(UIImage *)image {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] == 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

- (UIColor *)primaryColorFromBackgroundColor:(UIColor *)backgroundColor {
    NSArray *colorArray = [self getColorArrayWithCount:selectionColorPointCount];
    float maxColor = 0;
    UIColor *firstColor = [UIColor blackColor];
    for (UIColor *currentColor in colorArray) {
        float squareDistanceToBackground = [self squareDistanceInRGBSpaceBetweenColorA:currentColor colorB:backgroundColor];
        if (maxColor <= squareDistanceToBackground) {
            maxColor = squareDistanceToBackground;
            firstColor = currentColor;
        }
    }
    return [self getImprovedColorFromColor:firstColor backgroundColor:backgroundColor];
}

- (UIColor *)secondaryColorFromBackgroundColor:(UIColor *)backgroundColor primaryColor:(UIColor *)primaryColor {
    NSArray *colorArray = [self getColorArrayWithCount:selectionColorPointCount];
    float maxBackColor = 0;
    float maxFirstColor = 0;
    UIColor *secondColor = [UIColor blackColor];
    for (UIColor *currentColor in colorArray) {
        float squareDistanceToBackground = [self squareDistanceInRGBSpaceBetweenColorA:currentColor colorB:backgroundColor];
        float squareDistanceToFirstColor = [self squareDistanceInRGBSpaceBetweenColorA:currentColor colorB:primaryColor];
        BOOL condition = squareDistanceToBackground < squareDistanceToFirstColor ? maxBackColor <= squareDistanceToBackground : maxFirstColor <= squareDistanceToFirstColor;
        
        if ( condition ) {
            maxBackColor = squareDistanceToBackground;
            maxFirstColor = squareDistanceToFirstColor;
            secondColor = currentColor;
        }
    }
    return [self getImprovedColorFromColor:secondColor backgroundColor:backgroundColor];
}

- (UIColor *)detailColorFromBackgroundColor:(UIColor *)backgroundColor primaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor
{
    NSArray *colorArray = [self getColorArrayWithCount:selectionColorPointCount];
    float maxBackColor = 0;
    float maxFirstColor = 0;
    float maxSecondColor = 0;
    UIColor *detailColor = [UIColor blackColor];
    for (UIColor *currentColor in colorArray) {
        float squareDistanceToBackground = [self squareDistanceInRGBSpaceBetweenColorA:currentColor colorB:backgroundColor];
        float squareDistanceToFirstColor = [self squareDistanceInRGBSpaceBetweenColorA:currentColor colorB:primaryColor];
        float squareDistanceToSecondColor = [self squareDistanceInRGBSpaceBetweenColorA:currentColor colorB:secondaryColor];
        BOOL firstCondition = squareDistanceToBackground < squareDistanceToFirstColor ? maxBackColor <= squareDistanceToBackground : maxFirstColor <= squareDistanceToFirstColor;
        BOOL secondCodition = squareDistanceToBackground < squareDistanceToSecondColor ? maxBackColor <= squareDistanceToBackground : maxSecondColor <= squareDistanceToSecondColor;
        if ( firstCondition && secondCodition) {
            maxBackColor = squareDistanceToBackground;
            maxFirstColor = squareDistanceToFirstColor;
            maxSecondColor = squareDistanceToSecondColor;
            detailColor = currentColor;
        }
    }
    return [self getImprovedColorFromColor:detailColor backgroundColor:backgroundColor];
}

- (UIColor *)lighterColorForColor:(UIColor *)sourceColor {
    CGFloat r, g, b, a;
    if ([sourceColor getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0) green:MIN(g + 0.2, 1.0) blue:MIN(b + 0.2, 1.0) alpha:a];
    }
    return nil;
}
- (NSArray *)imageColors
{
    NSArray *colors =[self getColorArrayWithCount:selectionColorPointCount];
    CSColorSorter *sorter = [CSColorSorter colorSorterWithGranularity:2];
    NSArray *newColors = [sorter sortColors:colors];
    return newColors;
}
- (NSArray *)primaryColors
{
    NSArray *colors =[self getColorArrayWithCount:selectionColorPointCount];
    NSArray *newColors = [self imageColors];
    NSMutableArray *finalColors = [[self imageColors] mutableCopy];
    UIColor *backgroundColor = finalColors[0];
    [finalColors removeObjectAtIndex:0];
    for (UIColor *color in newColors) {
        if (![color cs_isCompatibleWithColor:backgroundColor]) {
            [finalColors removeObject:color];
        }
    }
    NSEnumerator *enumerator = [colors objectEnumerator];
    UIColor *curColor = nil;
    NSMutableArray *sortedColors = [NSMutableArray array];
    BOOL findDarkColor = ![backgroundColor cs_isDarkColor];
    
    while ((curColor = [enumerator nextObject]) != nil)
    {
        curColor = [curColor cs_colorWithMinimumSaturation:0.15];
        
        if ([curColor cs_isDarkColor] == findDarkColor) {
            [sortedColors addObject:curColor];
        }
    }
    NSMutableArray *colorArray = [NSMutableArray array];
    UIColor *primaryColor = nil;
    UIColor *secondaryColor = nil;
    UIColor *detailColor = nil;
    for (UIColor *curColor in sortedColors) {
        if (primaryColor == nil) {
            if ([curColor cs_isContrastingColor:backgroundColor]) {
                primaryColor = [colors count] > 0 ? curColor : [self defaultPrimaryColor];
            }
        } else if (secondaryColor == nil) {
            if (![primaryColor cs_isDistinct:curColor] || ![curColor cs_isContrastingColor:backgroundColor])
                continue;
            secondaryColor = [finalColors count] > 1 ? curColor : [self defaultSecondaryColor];
        } else if (detailColor == nil) {
            if (![secondaryColor cs_isDistinct:curColor] || ![primaryColor cs_isDistinct:curColor] || ![curColor cs_isContrastingColor:backgroundColor]) continue;
            detailColor = [colors count] > 2 ? curColor: [self defaultDetailColor];
            break;
        }
    }
    if (!primaryColor) {
        primaryColor = [colors count] > 0 ? [self primaryColorFromBackgroundColor:backgroundColor] : [self defaultPrimaryColor];
        
    }
    if (!secondaryColor) {
        secondaryColor = [colors count] > 1 ? [self secondaryColorFromBackgroundColor:backgroundColor primaryColor:primaryColor] : [self defaultSecondaryColor];
        
    }
    if (!detailColor) {
        detailColor = [colors count] > 2 ? [self detailColorFromBackgroundColor:backgroundColor primaryColor:primaryColor secondaryColor:secondaryColor] : [self defaultDetailColor];
    }
    
    [colorArray addObject:primaryColor];
    [colorArray addObject:secondaryColor];
    [colorArray addObject:detailColor];
    return colorArray;
    
}


@end
