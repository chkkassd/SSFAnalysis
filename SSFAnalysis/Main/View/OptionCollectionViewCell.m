//
//  OptionCollectionViewCell.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/24.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "OptionCollectionViewCell.h"

@implementation OptionCollectionViewCell

- (void)setOptionNameLabel:(UILabel *)optionNameLabel {
    _optionNameLabel = optionNameLabel;
    _optionNameLabel.layer.cornerRadius = 3.0;
    _optionNameLabel.layer.borderWidth = 0.5f;
    _optionNameLabel.layer.borderColor = [UIColor colorWithWhite:220/255.0 alpha:1.0].CGColor;
}
@end
