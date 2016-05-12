//
//  NSDate+Calendar.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)
//当前月的天数
- (NSUInteger)numberOfDayInCurrentMonth {
   return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

//当前月的第一天(nsdate)
- (NSDate *)firstDayOfCurrentMonth {
    NSDate *startDate = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    return startDate;
}

//给定的date在对应周中的顺序，即周几（nsuinteger）
- (NSUInteger)weeklyOrdinality {
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSWeekCalendarUnit forDate:self];
}
@end
