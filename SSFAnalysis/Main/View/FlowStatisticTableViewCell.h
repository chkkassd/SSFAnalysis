//
//  FlowStatisticTableViewCell.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/6/2.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowStatisticModel.h"

@interface FlowStatisticTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthSurplusLabel;

- (void)configureCellWithModel:(FlowStatisticModel *)model;
@end
