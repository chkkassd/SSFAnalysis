//
//  SSFAnalysisManager.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Bill+CoreDataProperties.h"

@class User;

@interface SSFAnalysisManager : NSObject

- (void)userLoginAndSaveWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void(^)(NSString *description,BOOL success))handler;
- (void)userSignUpAndSaveWithEmail:(NSString *)email displayName:(NSString *)displayName password:(NSString *)password completionHaneldr:(void(^)(NSString *description, BOOL success))handler;
- (void)signOut;
- (void)clearMyBills;

#pragma mark - about day
@property (NS_NONATOMIC_IOSONLY, readonly) float costOfTodayWithUser;//今日支出总计
@property (NS_NONATOMIC_IOSONLY, readonly) float incomeOfTodayWithUser;//今日收入总计
@property (NS_NONATOMIC_IOSONLY, readonly) float surplesOfTodayWithUser;//今日结余
- (CGFloat)costWithUserOfDay:(NSString *)day;//给定天的支出总计
- (CGFloat)incomeWithUserOfDay:(NSString *)day;//给定天的收入总计
- (CGFloat)surplesWithUserOfDay:(NSString *)day;//给定天的结余总计

#pragma mark - about month
@property (NS_NONATOMIC_IOSONLY, readonly) float costOfThisMonthWithUser;//今月支出总计
@property (NS_NONATOMIC_IOSONLY, readonly) float incomeOfThisMonthWithUser;//今月收入总计
@property (NS_NONATOMIC_IOSONLY, readonly) float averageOfCostThisMonthWithUser;//今月平均支出
@property (NS_NONATOMIC_IOSONLY, readonly) float averageOfIncomeThisMonthWithUser;//今月平均收入
@property (NS_NONATOMIC_IOSONLY, readonly) float surplesOfThisMonthWithUser;//今月结余

- (CGFloat)costWithUserOfMonth:(NSString *)month;//给定月的支出
- (CGFloat)incomeWithUserOfMonth:(NSString *)month;//给定月的收入
- (CGFloat)surplesWithUserOfMonth:(NSString *)month;//给定月的结余

@property (NS_NONATOMIC_IOSONLY, getter=getAllSubTypesOfCostThisMonth, readonly, copy) NSArray *allSubTypesOfCostThisMonth;//本月支出的详细类型
@property (NS_NONATOMIC_IOSONLY, getter=getAllSubTypesOfIncomeThisMonth, readonly, copy) NSArray *allSubTypesOfIncomeThisMonth;//本月收入的详细类型
- (CGFloat)percentOfCostThisMonthWithSubtype:(NSUInteger)subtype;//本月某项支出占比
- (CGFloat)percentOfIncomeThisMonthWithSubtype:(NSUInteger)subtype;//本月某项收入占比
- (CGFloat)moneyOfThisMonthWithSubtype:(NSUInteger)subtype;//本月某项类型的总计
@property (NS_NONATOMIC_IOSONLY, getter=getAllMyCostBillOfCurrentMonth, readonly, copy) NSArray *allMyCostBillOfCurrentMonth;//当月支出所有账单
@property (NS_NONATOMIC_IOSONLY, getter=getAllMyIncomeBillOfCurrentMonth, readonly, copy) NSArray *allMyIncomeBillOfCurrentMonth;//当月收入所有账单
@property (NS_NONATOMIC_IOSONLY, getter=getAllDatesOfCostThisMonth, readonly, copy) NSArray *allDatesOfCostThisMonth;//本月所有有支出的日期合集
@property (NS_NONATOMIC_IOSONLY, getter=getAllDatesOfIncomeThisMonth, readonly, copy) NSArray *allDatesOfIncomeThisMonth;//本月所有有收入的日期合集

#pragma mark - about year
@property (NS_NONATOMIC_IOSONLY, readonly) float costOfThisYearWithUser;//今年支出总计
@property (NS_NONATOMIC_IOSONLY, readonly) float incomeOfThisYearWithUser;//今年收入总计
@property (NS_NONATOMIC_IOSONLY, readonly) float averageOfCostThisYearWithUser;//今年平均支出
@property (NS_NONATOMIC_IOSONLY, readonly) float averageOfIncomeThisYearWithUser;//今年平均收入
@property (NS_NONATOMIC_IOSONLY, readonly) float surplesOfThisYearWithUser;//今年结余
@property (NS_NONATOMIC_IOSONLY, getter=getAllMonthsOfThisYear, readonly, copy) NSArray *allMonthsOfThisYear;//今年收入支出包含的月份

@property (nonatomic, strong) User *currentUser;
+ (instancetype)sharedManager;
@end
