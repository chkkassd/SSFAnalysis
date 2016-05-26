//
//  SSFAnalysisChartTableViewController+Handler.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFAnalysisChartTableViewController+Handler.h"
#import "SSFMoneyTypeManager.h"

@implementation SSFAnalysisChartTableViewController (Handler)
//@dynamic pieChartData;

- (void)configureCostPieChartData {
    NSArray *subtypes = [[SSFAnalysisManager sharedManager] getAllSubTypesOfCostThisMonth];
    if (!subtypes.count) {self.pieChartData = nil; return;}
    
    self.pieChartData = nil;
    self.pieChartData = [[NSMutableArray alloc] init];
    for (NSNumber *subtype in subtypes) {
        PieChartModel *model = [[PieChartModel alloc] init];
        model.nameString = [SSFMoneyTypeManager moneyTypeStringWithNumber:subtype];
        model.percent = [[SSFAnalysisManager sharedManager] percentOfCostThisMonthWithSubtype:[subtype integerValue]];
        model.color = [SSFMoneyTypeManager colorOfSubtypeWithNumber:subtype];
        [self.pieChartData addObject:model];
    }
}

- (void)configureIncomePieChartData {
    NSArray *subtypes = [[SSFAnalysisManager sharedManager] getAllSubTypesOfIncomeThisMonth];
    if (!subtypes.count) {self.pieChartData = nil; return;}
    
    self.pieChartData = nil;
    self.pieChartData = [[NSMutableArray alloc] init];
    for (NSNumber *subtype in subtypes) {
        PieChartModel *model = [[PieChartModel alloc] init];
        model.nameString = [SSFMoneyTypeManager moneyTypeStringWithNumber:subtype];
        model.percent = [[SSFAnalysisManager sharedManager] percentOfCostThisMonthWithSubtype:[subtype integerValue]];
        model.color = [SSFMoneyTypeManager colorOfSubtypeWithNumber:subtype];
        [self.pieChartData addObject:model];
    }
}

@end
