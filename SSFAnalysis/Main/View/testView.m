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
@property (nonatomic, strong) IBInspectable UIColor *color;
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
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    //1.creating a path
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 20, 20);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextClosePath(context);
    
    
}


@end
