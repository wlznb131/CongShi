//
//  CSFavoriteBlurView.m
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//  圆弧渐变适配

#import "CSFavoriteBlurView.h"

@implementation CSFavoriteBlurView

- (instancetype)initWithFrame:(CGRect)frame andCustomColor:(UIColor*)customColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.customColor = customColor;
    }
    return self;
}

- (void)setCustomColor:(UIColor*)customColor
{
    _customColor = customColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code

    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* gradientColor = nil;
    UIColor* gradientColor2 = nil;
    if (self.customColor) {
        gradientColor = self.customColor;
        gradientColor2 = [self.customColor colorWithAlphaComponent:0];
    }
    else {
        gradientColor = [UIColor lightGrayColor];
        gradientColor2 = [[UIColor lightGrayColor] colorWithAlphaComponent:0];
    }

    //// Gradient Declarations
    CGFloat gradientLocations[] = { 0, 1 };
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) @[ (id)gradientColor2.CGColor, (id)gradientColor.CGColor ], gradientLocations);

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CSAPP_WIDTH, CSAPP_HEIGHT)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    
#pragma mark - 圆弧模糊视图适配
    CGContextDrawRadialGradient(context, gradient,
        CGPointMake(CSAPP_WIDTH / 2, CSLayoutWidth(-114.84)), CSLayoutWidth(267.85),
        CGPointMake(CSAPP_WIDTH / 2, CSLayoutWidth(-222.58)), CSLayoutWidth(449.67),
        kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

    CGContextRestoreGState(context);

    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

    [self setNeedsDisplay];
}

@end
