//
//  CalendarCollectionViewCell.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "CalendarCollectionViewCell.h"

@implementation CalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithData:(NSString *)dataString {
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor colorWithWhite:240/255.0 alpha:1.0].CGColor;
    
    self.dayTextLabel.text = dataString;
}
@end
