//
//  FlowStatisticModel.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/6/2.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowStatisticModel : NSObject
@property (nonatomic, strong) NSString *month;
@property (nonatomic, assign) float monthIncome;
@property (nonatomic, assign) float monthCost;
@property (nonatomic, assign) float monthSurplus;
@end
