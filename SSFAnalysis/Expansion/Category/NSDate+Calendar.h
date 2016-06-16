//
//  NSDate+Calendar.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger numberOfDayInCurrentMonth;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDate *firstDayOfCurrentMonth;
@property (NS_NONATOMIC_IOSONLY, readonly) NSUInteger weeklyOrdinality;
@end
