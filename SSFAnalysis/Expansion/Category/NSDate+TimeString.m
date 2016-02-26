//
//  NSDate+TimeString.m
//  Chat
//
//  Created by ZHOU DENGFENG on 14/6/15.
//  Copyright (c) 2015 ZHOU DENGFENG DEREK. All rights reserved.
//

#import "NSDate+TimeString.h"

@implementation NSDate (TimeString)

- (NSString *)defaultDateString {
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
    }
    return [formatter stringFromDate:self];
}

@end
