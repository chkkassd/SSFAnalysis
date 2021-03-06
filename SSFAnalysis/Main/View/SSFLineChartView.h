//
//  testView.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/2/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,LineChartType) {
    LineChartType_Cost = 1,
    LineChartType_Income = 2
};

@interface SSFLineChartView : UIView
- (void)drawLineChartWithMonth:(NSInteger)month chartType:(LineChartType)type;
@end
