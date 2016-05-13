//
//  SSFCalendarViewController.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/13.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSFCalendarViewControllerDelegate;
@interface SSFCalendarViewController : UIViewController
@property (nonatomic, weak) id <SSFCalendarViewControllerDelegate> delegate;
@end

@protocol SSFCalendarViewControllerDelegate <NSObject>

- (void)SSFCalendarViewController:(SSFCalendarViewController *)controller didSelectedTime:(NSDate *)date;

@end