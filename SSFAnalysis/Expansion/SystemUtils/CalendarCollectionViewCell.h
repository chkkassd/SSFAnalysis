//
//  CalendarCollectionViewCell.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *dayTextLabel;
- (void)configureWithData:(NSString *)dataString;
@end
