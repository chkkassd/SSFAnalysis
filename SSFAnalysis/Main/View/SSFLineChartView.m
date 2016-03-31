//
//  testView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/2/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFLineChartView.h"

#define DefaultLineGapWidth 5
#define DefaultLineTopGapHeight 35
#define DefaultLineBottomGapHeight 20
#define DefaultDateGapWidth 20

IB_DESIGNABLE
@interface SSFLineChartView()
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;
@property (nonatomic, strong) IBInspectable UIColor *fillColor;

@end

@implementation SSFLineChartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 6;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = 6;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    [self setGradientBackgroundWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, self.frame.size.height)];
    [self setSeparateLine];
    [self drawText];
    [self drawLineChart];
}

//绘制渐变背景
- (void)setGradientBackgroundWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endpoint {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:255/255.0 green:158/255.0 blue:69/255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:255/255.0 green:85/255.0 blue:16/255.0 alpha:1.0].CGColor,nil];
    CGFloat gradientLocations[] = {0,1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(context, gradient, startPoint, endpoint, 0);
}

//绘制分割线
- (void)setSeparateLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(DefaultLineGapWidth, DefaultLineTopGapHeight)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - DefaultLineGapWidth, DefaultLineTopGapHeight)];
    [path moveToPoint:CGPointMake(DefaultLineGapWidth, self.frame.size.height - DefaultLineBottomGapHeight)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - DefaultLineGapWidth, self.frame.size.height - DefaultLineBottomGapHeight)];
    path.lineWidth = 1.0;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    [path closePath];
    [path stroke];

}

//绘制文字
- (void)drawText {
    NSDictionary *attribute = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                                };
    //绘制顶部统计
    NSString *string = @"日均支出";
    CGSize averageTextSize = [string boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [string drawAtPoint:CGPointMake(DefaultLineGapWidth, (DefaultLineTopGapHeight-averageTextSize.height)/2) withAttributes:attribute];
    
    NSString *totalString = @"本月总计支出";
    CGSize totalTextSize = [totalString boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [totalString drawAtPoint:CGPointMake(self.frame.size.width - DefaultLineGapWidth - totalTextSize.width, (DefaultLineTopGapHeight-totalTextSize.height)/2) withAttributes:attribute];
    
    //绘制底部日期
    CGFloat average = (self.frame.size.width - DefaultDateGapWidth*2)/31.0;
    NSString *dateOne = @"1";
    CGSize dateOneSize = [dateOne boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [dateOne drawAtPoint:CGPointMake(DefaultDateGapWidth + average - dateOneSize.width/2, self.frame.size.height - DefaultLineBottomGapHeight +(DefaultLineBottomGapHeight-dateOneSize.height)/2) withAttributes:attribute];
    
    NSString *dateTwo = @"7";
    CGSize dateTwoSize = [dateTwo boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [dateTwo drawAtPoint:CGPointMake(DefaultDateGapWidth + average*7 - dateTwoSize.width/2, self.frame.size.height - DefaultLineBottomGapHeight +(DefaultLineBottomGapHeight-dateTwoSize.height)/2) withAttributes:attribute];
    
    NSString *dateThree = @"14";
    CGSize dateThreeSize = [dateThree boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [dateThree drawAtPoint:CGPointMake(DefaultDateGapWidth + average*14 - dateThreeSize.width/2, self.frame.size.height - DefaultLineBottomGapHeight +(DefaultLineBottomGapHeight-dateThreeSize.height)/2) withAttributes:attribute];
    
    NSString *dateFour = @"21";
    CGSize dateFourSize = [dateFour boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [dateFour drawAtPoint:CGPointMake(DefaultDateGapWidth + average*21 - dateFourSize.width/2, self.frame.size.height - DefaultLineBottomGapHeight +(DefaultLineBottomGapHeight-dateFourSize.height)/2) withAttributes:attribute];
    
    NSString *dateFive = @"28";
    CGSize dateFiveSize = [dateFive boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [dateFive drawAtPoint:CGPointMake(DefaultDateGapWidth + average*28 - dateFiveSize.width/2, self.frame.size.height - DefaultLineBottomGapHeight +(DefaultLineBottomGapHeight-dateFiveSize.height)/2) withAttributes:attribute];
}

//绘制折线
- (void)drawLineChart {
    CGFloat average = (self.frame.size.width - DefaultDateGapWidth*2)/31.0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(DefaultDateGapWidth + average, self.frame.size.height-DefaultLineBottomGapHeight - 6000/100.0)];
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*2, self.frame.size.height-DefaultLineBottomGapHeight -1600/100.0)];
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*3, self.frame.size.height-DefaultLineBottomGapHeight -2600/100.0)];
    
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*7, self.frame.size.height-DefaultLineBottomGapHeight -3600/100.0)];
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*10, self.frame.size.height-DefaultLineBottomGapHeight -1400/100.0)];
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*15, self.frame.size.height-DefaultLineBottomGapHeight -600/100.0)];
    
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*20, self.frame.size.height-DefaultLineBottomGapHeight -4600/100.0)];
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*25, self.frame.size.height-DefaultLineBottomGapHeight -10000/100.0)];
    [path addLineToPoint:CGPointMake(DefaultDateGapWidth + average*30, self.frame.size.height-DefaultLineBottomGapHeight -8600/100.0)];
    
    path.lineWidth = 1.0;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    [path stroke];
}
@end
