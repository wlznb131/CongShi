//
//  CSCustomBackButton.m
//  CongShi
//
//  Created by Archy on 15/12/30.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSCustomBackButton.h"

@implementation CSCustomBackButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 20, 26)];
    if (self) {
        self.opaque = NO;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(11, 3)];
    [path addLineToPoint:CGPointMake(3, 12)];
    [path addLineToPoint:CGPointMake(11, 21)];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    CGContextAddPath(context, path.CGPath);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, 3);
    [self.customColor set];
    CGContextStrokePath(context);
    [self setNeedsDisplay];
    
}

@end
