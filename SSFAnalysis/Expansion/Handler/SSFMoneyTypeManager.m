//
//  SSFMoneyTypeManager.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/24.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFMoneyTypeManager.h"
#import "Bill+CoreDataProperties.h"

@implementation SSFMoneyTypeManager
+ (NSNumber *)numberWithMoneyTypeString:(NSString *)string {
    if ([string isEqualToString:@"吃饭"]) {
        return @(BILL_SUBTYPE_EAT);
    } else if ([string isEqualToString:@"交通"]) {
        return @(BILL_SUBTYPE_TRAFFIC);
    } else if ([string isEqualToString:@"服饰"]) {
        return @(BILL_SUBTYPE_CLOTHES);
    } else if ([string isEqualToString:@"住宿"]) {
        return @(BILL_SUBTYPE_STAY);
    } else if ([string isEqualToString:@"娱乐"]) {
        return @(BILL_SUBTYPE_ENTERTAINMENT);
    } else if ([string isEqualToString:@"购物"]) {
        return @(BILL_SUBTYPE_SHOPPING);
    } else if ([string isEqualToString:@"其他支出"]) {
        return @(BILL_SUBTYPE_OTHERCOST);
    } else if ([string isEqualToString:@"工资"]) {
        return @(BILL_SUBTYPE_SALARY);
    } else if ([string isEqualToString:@"投资"]) {
        return @(BILL_SUBTYPE_INVESTMENT);
    } else if ([string isEqualToString:@"兼职"]) {
        return @(BILL_SUBTYPE_PART_TIME_JOB);
    } else return nil;
}

+ (NSString *)moneyTypeStringWithNumber:(NSNumber *)number {
    NSInteger integerNumber = [number integerValue];
    if (integerNumber == BILL_SUBTYPE_EAT) {
        return @"吃饭";
    } else if (integerNumber == BILL_SUBTYPE_TRAFFIC) {
        return @"交通";
    } else if (integerNumber == BILL_SUBTYPE_CLOTHES) {
        return @"服饰";
    } else if (integerNumber == BILL_SUBTYPE_STAY) {
        return @"住宿";
    } else if (integerNumber == BILL_SUBTYPE_ENTERTAINMENT) {
        return @"娱乐";
    } else if (integerNumber == BILL_SUBTYPE_SHOPPING) {
        return @"购物";
    } else if (integerNumber == BILL_SUBTYPE_OTHERCOST) {
        return @"其他支出";
    } else if (integerNumber == BILL_SUBTYPE_SALARY) {
        return @"工资";
    } else if (integerNumber == BILL_SUBTYPE_INVESTMENT) {
        return @"投资";
    } else if (integerNumber == BILL_SUBTYPE_PART_TIME_JOB) {
        return @"兼职";
    } else return nil;
}

+ (UIColor *)colorOfSubtypeWithNumber:(NSNumber *)number {
    NSInteger integerNumber = [number integerValue];
    if (integerNumber == BILL_SUBTYPE_EAT) {
        return [UIColor redColor];
    } else if (integerNumber == BILL_SUBTYPE_TRAFFIC) {
        return [UIColor orangeColor];
    } else if (integerNumber == BILL_SUBTYPE_CLOTHES) {
        return [UIColor blueColor];
    } else if (integerNumber == BILL_SUBTYPE_STAY) {
        return [UIColor greenColor];
    } else if (integerNumber == BILL_SUBTYPE_ENTERTAINMENT) {
        return [UIColor grayColor];
    } else if (integerNumber == BILL_SUBTYPE_SHOPPING) {
        return [UIColor yellowColor];
    } else if (integerNumber == BILL_SUBTYPE_OTHERCOST) {
        return [UIColor redColor];
    } else if (integerNumber == BILL_SUBTYPE_SALARY) {
        return [UIColor redColor];
    } else if (integerNumber == BILL_SUBTYPE_INVESTMENT) {
        return [UIColor orangeColor];
    } else if (integerNumber == BILL_SUBTYPE_PART_TIME_JOB) {
        return [UIColor blueColor];
    } else return [UIColor redColor];
}
@end
