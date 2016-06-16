//
//  CalendarFlowLayout.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSFCalendarView;

@interface CalendarFlowLayout : UICollectionViewFlowLayout
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCalendarView:(SSFCalendarView *)view NS_DESIGNATED_INITIALIZER;
@end
