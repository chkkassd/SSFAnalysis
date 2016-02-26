//
//  NSDictionary+SafetyCheck.h
//  Chat
//
//  Created by ZHOU DENGFENG on 11/6/15.
//  Copyright (c) 2015 ZHOU DENGFENG DEREK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafetyCheck)

- (NSString *)stringForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;

@end
