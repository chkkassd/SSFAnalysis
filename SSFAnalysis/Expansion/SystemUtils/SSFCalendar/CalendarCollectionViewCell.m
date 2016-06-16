//
//  CalendarCollectionViewCell.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
#import "NSString+Tony.h"

@implementation CalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithData:(NSString *)dataString monthYear:(NSString *)monthYear {
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor colorWithWhite:240/255.0 alpha:1.0].CGColor;
    self.dayTextLabel.text = dataString;
    
    NSString *timeString = [monthYear stringByAppendingString:[self dayStringWithString:dataString]];
    NSLog(@"opopopopopopopo:%@",timeString);
    if ([[NSString stringToDayTranslatedFromDate:[NSDate date]] isEqualToString:timeString]) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (NSString *)dayStringWithString:(NSString *)dayString {
    NSInteger a = dayString.integerValue;
    if (a < 10 && a > 0) {
        dayString = [NSString stringWithFormat:@"-0%@",dayString];
    } else if (a >= 10) {
        dayString = [NSString stringWithFormat:@"-%@",dayString];
    }
    return dayString;
}
@end
