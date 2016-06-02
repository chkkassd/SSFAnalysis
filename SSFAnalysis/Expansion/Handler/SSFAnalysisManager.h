//
//  SSFAnalysisManager.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface SSFAnalysisManager : NSObject

- (void)userLoginAndSaveWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void(^)(NSString *description,BOOL success))handler;
- (void)signOut;
- (void)clearMyBills;

#pragma mark - about day
- (float)costOfTodayWithUser;//今日支出总计
- (float)incomeOfTodayWithUser;//今日收入总计
- (float)surplesOfTodayWithUser;//今日结余
- (float)costWithUserOfDay:(NSString *)day;//给定天的支出总计
- (float)incomeWithUserOfDay:(NSString *)day;//给定天的收入总计
- (float)surplesWithUserOfDay:(NSString *)day;//给定天的结余总计

#pragma mark - about month
- (float)costOfThisMonthWithUser;//今月支出总计
- (float)incomeOfThisMonthWithUser;//今月收入总计
- (float)averageOfCostThisMonthWithUser;//今月平均支出
- (float)averageOfIncomeThisMonthWithUser;//今月平均收入
- (float)surplesOfThisMonthWithUser;//今月结余

- (float)costWithUserOfMonth:(NSString *)month;//给定月的支出
- (float)incomeWithUserOfMonth:(NSString *)month;//给定月的收入
- (float)surplesWithUserOfMonth:(NSString *)month;//给定月的结余

- (NSArray *)getAllSubTypesOfCostThisMonth;//本月支出的详细类型
- (NSArray *)getAllSubTypesOfIncomeThisMonth;//本月收入的详细类型
- (float)percentOfCostThisMonthWithSubtype:(BILL_SUBTYPE)subtype;//本月某项支出占比
- (float)percentOfIncomeThisMonthWithSubtype:(BILL_SUBTYPE)subtype;//本月某项收入占比
- (float)moneyOfThisMonthWithSubtype:(BILL_SUBTYPE)subtype;//本月某项类型的总计
- (NSArray *)getAllMyCostBillOfCurrentMonth;//当月支出所有账单
- (NSArray *)getAllMyIncomeBillOfCurrentMonth;//当月收入所有账单
- (NSArray *)getAllDatesOfCostThisMonth;//本月所有有支出的日期合集
- (NSArray *)getAllDatesOfIncomeThisMonth;//本月所有有收入的日期合集

#pragma mark - about year
- (float)costOfThisYearWithUser;//今年支出总计
- (float)incomeOfThisYearWithUser;//今年收入总计
- (float)averageOfCostThisYearWithUser;//今年平均支出
- (float)averageOfIncomeThisYearWithUser;//今年平均收入
- (float)surplesOfThisYearWithUser;//今年结余
- (NSArray *)getAllMonthsOfThisYear;//今年收入支出包含的月份

@property (nonatomic, strong) User *currentUser;
+ (instancetype)sharedManager;
@end
