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

- (float)costOfTodayWithUser;//今日支出总计
- (float)incomeOfTodayWithUser;//今日收入总计
- (float)surplesOfTodayWithUser;//今日结余
- (float)costOfThisMonthWithUser;//今月支出总计
- (float)incomeOfThisMonthWithUser;//今月收入总计
- (float)surplesOfThisMonthWithUser;//今月结余
- (float)costOfThisYearWithUser;//今年支出总计
- (float)incomeOfThisYearWithUser;//今年收入总计
- (float)surplesOfThisYearWithUser;//今年结余

@property (nonatomic, strong) User *currentUser;
+ (instancetype)sharedManager;
@end
