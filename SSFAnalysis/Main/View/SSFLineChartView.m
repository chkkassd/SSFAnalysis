//
//  testView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/2/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFLineChartView.h"
#import "SSFAnalysisManager.h"

#define DefaultLineGapWidth 5
#define DefaultLineTopGapHeight 35
#define DefaultLineBottomGapHeight 20
#define DefaultDateGapWidth 20
#define DefaultMoneyHeightRatio 50 //金钱比例尺

IB_DESIGNABLE
@interface SSFLineChartView()
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;
@property (nonatomic, strong) IBInspectable UIColor *fillColor;
@property (nonatomic, strong) UIBezierPath *chartPath;
@property (nonatomic, assign) LineChartType lineChartType;
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
    
    [self setGradientBackgroundWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, self.frame.size.height)];
    [self setSeparateLine];
    [self drawText];
    [self.chartPath stroke];
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
    
    NSString *leftString;
    NSString *rightString;
    float averageMoney,totalMoney;
    if (self.lineChartType == LineChartType_Cost) {
        leftString = @"日均支出";
        rightString = @"本月总计支出";
        averageMoney = [[SSFAnalysisManager sharedManager] averageOfCostThisMonthWithUser];
        totalMoney = [[SSFAnalysisManager sharedManager] costOfThisMonthWithUser];
    } else if (self.lineChartType == LineChartType_Income) {
        leftString = @"日均收入";
        rightString = @"本月总计收入";
        averageMoney = [[SSFAnalysisManager sharedManager] averageOfIncomeThisMonthWithUser];
        totalMoney = [[SSFAnalysisManager sharedManager] incomeOfThisMonthWithUser];
    }

    //绘制顶部统计
    NSString *string = [NSString stringWithFormat:@"%@:%.2f",leftString,averageMoney] ;
    CGSize averageTextSize = [string boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [string drawAtPoint:CGPointMake(DefaultLineGapWidth, (DefaultLineTopGapHeight-averageTextSize.height)/2) withAttributes:attribute];
    
    NSString *totalString = [NSString stringWithFormat:@"%@:%.2f",rightString,totalMoney];
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
    
    NSString *unitStringX = @"(日)";
    CGSize unitStringXSize = [unitStringX boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [unitStringX drawAtPoint:CGPointMake(self.frame.size.width - unitStringXSize.width, self.frame.size.height - DefaultLineBottomGapHeight +(DefaultLineBottomGapHeight-unitStringXSize.height)/2) withAttributes:attribute];
    
    
    NSDictionary *attribute2 = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:8.0],
                                };
    
    NSString *minMoney = @"0";
    CGSize minMoneySize = [minMoney boundingRectWithSize:self.frame.size options:NSStringDrawingUsesFontLeading attributes:attribute2 context:nil].size;
    [minMoney drawAtPoint:CGPointMake(DefaultLineGapWidth, self.frame.size.height - DefaultLineBottomGapHeight - minMoneySize.height) withAttributes:attribute2];
    
    NSInteger maxMoneyNumber = (self.frame.size.height - DefaultLineTopGapHeight - DefaultLineBottomGapHeight)*DefaultMoneyHeightRatio;
    NSString *maxMoney = [NSString stringWithFormat:@"%ld(元)",(long)maxMoneyNumber];
    [maxMoney drawAtPoint:CGPointMake(DefaultLineGapWidth, DefaultLineTopGapHeight) withAttributes:attribute2];
}

//绘制折线:month 0 represent current month;otherwise,represent the correspondding month
- (void)drawLineChartWithMonth:(NSInteger)month chartType:(LineChartType)type {
    self.lineChartType = type;
    self.chartPath = nil;
    self.chartPath = [UIBezierPath bezierPath];
    self.chartPath.lineWidth = 1.0;
    self.chartPath.lineJoinStyle = kCGLineJoinRound;
    self.chartPath.lineCapStyle = kCGLineCapRound;
    
    if (month == 0) {
        //当前月
        NSArray *bills = nil;
        if (type == LineChartType_Cost) {
            bills = [[SSFAnalysisManager sharedManager] getAllMyCostBillOfCurrentMonth];
        } else if (type == LineChartType_Income) {
            bills = [[SSFAnalysisManager sharedManager] getAllMyIncomeBillOfCurrentMonth];
        }
        if (bills.count) {
            for (NSInteger i = 0; i < bills.count; i++) {
                if (i == 0) {
                    Bill *bill = bills[i];
                    [self.chartPath moveToPoint:CGPointMake([self xValueForPotinTranslatedFromBill:bill], [self yValueForPotinTranslatedFromBill:bill])];
                } else {
                    Bill *bill = bills[i];
                    [self.chartPath addLineToPoint:CGPointMake([self xValueForPotinTranslatedFromBill:bill], [self yValueForPotinTranslatedFromBill:bill])];
                }
            }
        }
        
    } else {
        //其他月
    }
    
    [self setNeedsDisplay];
}

//账单时间转化为x坐标
- (CGFloat)xValueForPotinTranslatedFromBill:(Bill *)bill {
    CGFloat x = 0.00;
    CGFloat average = (self.frame.size.width - DefaultDateGapWidth*2)/31.0;
    NSString *dayString = [[bill.day componentsSeparatedByString:@"-"] lastObject];
    NSInteger day = [dayString integerValue];
    x = DefaultDateGapWidth + average * day;
    return x;
}

//账单金额转化为y坐标
- (CGFloat)yValueForPotinTranslatedFromBill:(Bill *)bill {
    CGFloat y = 0.00;
    float amount = [bill.amount floatValue];
    y = self.frame.size.height - DefaultLineBottomGapHeight - amount/DefaultMoneyHeightRatio;
    return y;
}
@end
