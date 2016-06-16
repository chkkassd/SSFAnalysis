//
//  FlowStatisticModel.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/6/2.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlowStatisticModel : NSObject
@property (nonatomic, copy) NSString *month;
@property (nonatomic, assign) CGFloat monthIncome;
@property (nonatomic, assign) CGFloat monthCost;
@property (nonatomic, assign) CGFloat monthSurplus;
@end
