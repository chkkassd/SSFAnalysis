//
//  PieChartModel.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//  SSFPieChartView的数据model

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PieChartModel : NSObject
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, assign) float percent;
@property (nonatomic, strong) UIColor *color;
@end
