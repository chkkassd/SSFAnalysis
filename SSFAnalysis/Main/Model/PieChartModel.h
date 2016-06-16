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
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat money;
@end
