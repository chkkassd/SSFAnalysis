//
//  SSFFlowStatisticTableViewController+Handler.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/6/2.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFFlowStatisticTableViewController+Handler.h"

@implementation SSFFlowStatisticTableViewController (Handler)

- (void)configureTableViewData {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSArray *monthsOfThisYear = [[SSFAnalysisManager sharedManager] getAllMonthsOfThisYear];
    if (!monthsOfThisYear.count) {arr = nil; return;}
    
    for (int i = 0; i < monthsOfThisYear.count; i++) {
        NSString *month = monthsOfThisYear[i];
        FlowStatisticModel *model = [[FlowStatisticModel alloc] init];
        model.month = month;
        model.monthCost = [[SSFAnalysisManager sharedManager] costWithUserOfMonth:month];
        model.monthIncome = [[SSFAnalysisManager sharedManager] incomeWithUserOfMonth:month];
        model.monthSurplus = [[SSFAnalysisManager sharedManager] surplesWithUserOfMonth:month];
        [arr addObject:model];
    }
    self.dataArr = arr;
}
@end
