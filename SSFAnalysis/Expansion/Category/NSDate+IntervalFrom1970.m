//
//  NSDate+IntervalFrom1970.m
//  Chat
//
//  Created by ZHOU DENGFENG on 14/6/15.
//  Copyright (c) 2015 ZHOU DENGFENG DEREK. All rights reserved.
//

#import "NSDate+IntervalFrom1970.h"

@implementation NSDate (IntervalFrom1970)

- (NSString *)intervalForStringFrom1970 {
    NSTimeInterval interval = [self timeIntervalSince1970] * 1000;
    return [@(interval) stringValue];
}

+ (NSDate *)dateForIntervaleForStringFrom1970:(NSString *)intervalString {
    NSTimeInterval interval = [intervalString doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}

- (NSString *)intervalForStringFromReferenceDate {
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate];
    return [@(interval) stringValue];
}

+ (NSDate *)dateForIntervaleForStringFromReferenceDate:(NSString *)intervalString {
    NSTimeInterval interval = [intervalString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return date;
}

@end
