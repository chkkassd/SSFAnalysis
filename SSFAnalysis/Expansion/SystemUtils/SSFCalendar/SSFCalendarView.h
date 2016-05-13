//
//  SSFCalendarView.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
// 调用的时候只需alloc,initWithFrame,即可

#import <UIKit/UIKit.h>

@protocol SSFCalendarViewDelegate;
@interface SSFCalendarView : UIView
@property (nonatomic, weak) id <SSFCalendarViewDelegate> delegate;
@end

@protocol SSFCalendarViewDelegate <NSObject>

- (void)SSFCalendarView:(SSFCalendarView *)view didSelectTime:(NSDate *)date;

@end