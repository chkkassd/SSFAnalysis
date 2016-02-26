//
//  NSString+RegularCheck.m
//  Chat
//
//  Created by 赛峰 施 on 15/8/17.
//  Copyright (c) 2015年 CZS Team 2015. All rights reserved.
//

#import "NSString+RegularCheck.h"

@implementation NSString (RegularCheck)
//邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
