//
//  SSFCalendarViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/13.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFCalendarViewController.h"
#import "SSFCalendarView.h"

@interface SSFCalendarViewController ()<SSFCalendarViewDelegate>

@end

@implementation SSFCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SSFCalendarView *calendarView = [[SSFCalendarView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 350)];
    calendarView.delegate = self;
    [self.view addSubview:calendarView];
}

#pragma mark - SSFCalendarViewDelegate
- (void)SSFCalendarView:(SSFCalendarView *)view didSelectTime:(NSDate *)date {
    [self.delegate SSFCalendarViewController:self didSelectedTime:date];
}
@end
