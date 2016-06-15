//
//  SSFPieChartView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/23.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFPieChartView.h"
#import "PieChartModel.h"

static const NSInteger DefaultWidth = 80;

@interface SSFPieChartView()
@property (strong, nonatomic) UIBezierPath *circlePath;
@property (strong, nonatomic) NSMutableArray *subregionArr;//百分比圆弧layer的数组
@end

@implementation SSFPieChartView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withModel:(NSArray *)modelArr {
    self = [super initWithFrame:frame];
    if (self) {
        self.circlePath = [self getBigCirclePathWithFrame:frame];
        [self drawBigCircle];
        [self drawSubregionWithModel:modelArr];
    }
    return self;
}

//绘制底色圆饼图
- (void)drawBigCircle {
    CAShapeLayer *bigCircleLayer = [CAShapeLayer layer];
    bigCircleLayer.path = self.circlePath.CGPath;
    bigCircleLayer.strokeColor = [UIColor colorWithWhite:240/255.0 alpha:1.0].CGColor;
    bigCircleLayer.fillColor = [UIColor clearColor].CGColor;
    bigCircleLayer.lineWidth = DefaultWidth;
    [self.layer addSublayer:bigCircleLayer];
}

//绘制百分比圆饼图
- (void)drawSubregionWithModel:(NSArray *)modelArr {
    if (!modelArr.count) {[self clearAllSubregions]; return;}
    else [self clearAllSubregions];
    
    CGFloat startAngler = 0.0;
    for (PieChartModel *model in modelArr) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = self.circlePath.CGPath;
        layer.lineWidth = DefaultWidth;
        layer.strokeColor = model.color.CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeStart = startAngler;
        layer.strokeEnd = startAngler + model.percent;
        [self.layer addSublayer:layer];
        startAngler += model.percent;
        [self.subregionArr addObject:layer];
        
        [self animationWithSubregionLayer:layer];
    }
}

- (void)clearAllSubregions {
    if (self.subregionArr.count) {
        for (CAShapeLayer *layer in self.subregionArr) {
            [layer removeFromSuperlayer];
        }
    }
    self.subregionArr = nil;
    self.subregionArr = [[NSMutableArray alloc] init];
}

- (UIBezierPath *)getBigCirclePathWithFrame:(CGRect)frame {
    CGFloat radius;
    if (frame.size.width > frame.size.height) {
        radius = frame.size.height/2 - DefaultWidth/2;
    } else radius = frame.size.width/2 - DefaultWidth/2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2) radius:radius startAngle:M_PI*(-0.5) endAngle:M_PI*1.5 clockwise:YES];
    return path;
}

//animation
- (void)animationWithSubregionLayer:(CAShapeLayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.0f;
    animation.fromValue = @(layer.strokeStart);
    animation.toValue = @(layer.strokeEnd);
    animation.autoreverses = NO;
    animation.delegate = self;
    [layer addAnimation:animation forKey:@"strokeEnd"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}
@end
