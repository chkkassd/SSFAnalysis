//
//  FlowStatisticTableViewCell.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/6/2.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "FlowStatisticTableViewCell.h"

@implementation FlowStatisticTableViewCell
- (void)configureCellWithModel:(FlowStatisticModel *)model {
    self.monthLabel.text = model.month;
    self.monthIncomeLabel.text = [NSString stringWithFormat:@"%.2f", model.monthIncome];
    self.monthCostLabel.text = [NSString stringWithFormat:@"%.2f", model.monthCost];
    self.monthSurplusLabel.text = [NSString stringWithFormat:@"%.2f", model.monthSurplus];
}
@end
