//
//  testView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/2/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "testView.h"

IB_DESIGNABLE
@interface testView()
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;
@property (nonatomic, strong) IBInspectable UIColor *fillColor;
@end

@implementation testView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetAlpha(context, 0.5);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 200)];
    [path addLineToPoint:CGPointMake(20, 199)];
    [path addLineToPoint:CGPointMake(30, 189)];
    [path addLineToPoint:CGPointMake(40, 100)];
    [path addLineToPoint:CGPointMake(50, 136)];
    [path addLineToPoint:CGPointMake(60, 179)];
    
    path.lineWidth = 2.0;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
//    [path closePath];
    [path stroke];
//    [path fill];

    
}


@end
