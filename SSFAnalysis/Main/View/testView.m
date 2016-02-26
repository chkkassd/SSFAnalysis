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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, 80, 100, 60, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context,self.color.CGColor);
    CGContextDrawPath(context, kCGPathFill);
}


@end
