//
//  AnalysisChartTableViewCell.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartModel.h"

@interface AnalysisChartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;

- (void)configureTableViewCellwithModel:(PieChartModel *)model;
@end
