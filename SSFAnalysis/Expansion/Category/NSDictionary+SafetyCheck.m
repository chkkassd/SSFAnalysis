//
//  NSDictionary+SafetyCheck.m
//  Chat
//
//  Created by ZHOU DENGFENG on 11/6/15.
//  Copyright (c) 2015 ZHOU DENGFENG DEREK. All rights reserved.
//

#import "NSDictionary+SafetyCheck.h"

@implementation NSDictionary (SafetyCheck)

- (NSString *)stringForKey:(NSString *)key {
    id obj = self[key];
    if ([obj isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)obj).stringValue;
    } else if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    } else {
        return nil;
    }
}

- (NSInteger)integerForKey:(NSString *)key {
    id obj = self[key];
    if ([obj isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)obj).integerValue;
    } else if ([obj isKindOfClass:[NSString class]]) {
        return ((NSString *)obj).integerValue;
    } else {
        return NSNotFound;
    }
}

@end
