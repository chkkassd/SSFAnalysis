//
//  AnalysisChartTableViewCell.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/27.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "AnalysisChartTableViewCell.h"
#import "NSString+Tony.h"

@implementation AnalysisChartTableViewCell
- (void)configureTableViewCellwithModel:(PieChartModel *)model {
    self.nameStringLabel.text = model.nameString;
    self.percentLabel.text = [NSString formatStringForPercentageWithNumber:@(model.percent)];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",model.money];
    self.colorView.backgroundColor = model.color;
}

- (void)setColorView:(UIView *)colorView {
    _colorView = colorView;
    _colorView.layer.cornerRadius = 5.0f;
}

@end
