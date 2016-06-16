//
//  SSFAnalysisChartTableViewController+Handler.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFAnalysisChartTableViewController+Handler.h"
#import "SSFMoneyTypeManager.h"
#import "SSFAnalysisManager.h"
#import "PieChartModel.h"

@implementation SSFAnalysisChartTableViewController (Handler)

- (void)configureCostPieChartData {
    NSArray *subtypes = [SSFAnalysisManager sharedManager].allSubTypesOfCostThisMonth;
    if (!subtypes.count) {self.pieChartData = nil; return;}
    
    self.pieChartData = nil;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSNumber *subtype in subtypes) {
        PieChartModel *model = [[PieChartModel alloc] init];
        model.nameString = [SSFMoneyTypeManager moneyTypeStringWithNumber:subtype];
        model.percent = [[SSFAnalysisManager sharedManager] percentOfCostThisMonthWithSubtype:subtype.integerValue];
        model.color = [SSFMoneyTypeManager colorOfSubtypeWithNumber:subtype];
        model.money = [[SSFAnalysisManager sharedManager] moneyOfThisMonthWithSubtype:subtype.integerValue];
        [arr addObject:model];
    }
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"percent" ascending:NO];
    self.pieChartData = [arr sortedArrayUsingDescriptors:@[descriptor]];
}

- (void)configureIncomePieChartData {
    NSArray *subtypes = [SSFAnalysisManager sharedManager].allSubTypesOfIncomeThisMonth;
    if (!subtypes.count) {self.pieChartData = nil; return;}
    
    self.pieChartData = nil;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSNumber *subtype in subtypes) {
        PieChartModel *model = [[PieChartModel alloc] init];
        model.nameString = [SSFMoneyTypeManager moneyTypeStringWithNumber:subtype];
        model.percent = [[SSFAnalysisManager sharedManager] percentOfIncomeThisMonthWithSubtype:subtype.integerValue];
        model.color = [SSFMoneyTypeManager colorOfSubtypeWithNumber:subtype];
        model.money = [[SSFAnalysisManager sharedManager] moneyOfThisMonthWithSubtype:subtype.integerValue];
        [arr addObject:model];
    }
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"percent" ascending:NO];
    self.pieChartData = [arr sortedArrayUsingDescriptors:@[descriptor]];
}

@end
