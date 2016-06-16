//
//  NSDate+IntervalFrom1970.h
//  Chat
//
//  Created by ZHOU DENGFENG on 14/6/15.
//  Copyright (c) 2015 ZHOU DENGFENG DEREK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IntervalFrom1970)

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *intervalForStringFrom1970;
+ (NSDate *)dateForIntervaleForStringFrom1970:(NSString *)intervalString;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *intervalForStringFromReferenceDate;
+ (NSDate *)dateForIntervaleForStringFromReferenceDate:(NSString *)intervalString;
@end
