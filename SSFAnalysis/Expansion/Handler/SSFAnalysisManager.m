//
//  SSFAnalysisManager.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFAnalysisManager.h"
#import "SSFNetWork.h"
#import "CoreDataManager.h"
#import "NSString+Tony.h"

@interface SSFAnalysisManager()
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainQueueContext;
@end

@implementation SSFAnalysisManager

#pragma mark - about network

-(void)userLoginAndSaveWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void (^)(NSString *,BOOL))handler {
    [[SSFNetWork sharedNetWork] signInWithEmail:email password:password completion:^(NSString *obj, NSData *resumeData) {
        if (obj) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:[obj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",resultDic);
            if ([resultDic[@"response_code"] integerValue] == 100 ) {
                //do save operation
                NSDictionary *userDic = resultDic[@"user"];
                [[CoreDataManager sharedManager] startConnectCoreData];
                [User updateUserWithInfo:userDic inManagedObjectContext:self.mainQueueContext];
                [self.mainQueueContext save:NULL];
                [[NSUserDefaults standardUserDefaults] setObject:userDic[@"user_id"] forKey:LOGIN_USER_ID_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
                handler(nil,YES);
            } else {
                handler(@"登录失败，稍后再试",NO);
            }
        } else {
            handler(@"网络异常，稍后再试",NO);
        }
    }];
}

- (void)signOut {
    [[CoreDataManager sharedManager] stopConnectCoreData];
    [[NSUserDefaults standardUserDefaults] setObject:NULL forKey:LOGIN_USER_ID_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NSFetchedResultsController deleteCacheWithName:BILL_FETCHED_RESULTS_CACHE_NAME];
}

- (void)clearMyBills {
   
}

#pragma mark - about data

//today
- (float)costOfTodayWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"day = %@ && type = %@",[NSString stringToDayTranslatedFromDate:[NSDate date]],@(BILL_TYPE_COST)];
    return [self getTotalWithPredicate:predicate];
}

- (float)incomeOfTodayWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"day = %@ && type = %@",[NSString stringToDayTranslatedFromDate:[NSDate date]],@(BILL_TYPE_INCOME)];
    return [self getTotalWithPredicate:predicate];
}

- (float)surplesOfTodayWithUser {
    return ([self incomeOfTodayWithUser] - [self costOfTodayWithUser]);
}

- (float)costWithUserOfDay:(NSString *)day {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"day = %@ && type = %@",day,@(BILL_TYPE_COST)];
    return [self getTotalWithPredicate:predicate];
}

- (float)incomeWithUserOfDay:(NSString *)day {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"day = %@ && type = %@",day,@(BILL_TYPE_INCOME)];
    return [self getTotalWithPredicate:predicate];
}

- (float)surplesWithUserOfDay:(NSString *)day {
    return ([self incomeWithUserOfDay:day] - [self costWithUserOfDay:day]);
}

//this month
- (float)costOfThisMonthWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(BILL_TYPE_COST)];
    return [self getTotalWithPredicate:predicate];
}

- (float)incomeOfThisMonthWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(BILL_TYPE_INCOME)];
    return [self getTotalWithPredicate:predicate];
}

- (float)surplesOfThisMonthWithUser {
    NSLog(@"==========%f,%f",[self incomeOfThisMonthWithUser],[self costOfThisMonthWithUser]);
    return ([self incomeOfThisMonthWithUser] - [self costOfThisMonthWithUser]);
}

- (float)averageOfCostThisMonthWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(BILL_TYPE_COST)];
    return [self getAverageWithPredicate:predicate];
}

- (float)averageOfIncomeThisMonthWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(BILL_TYPE_INCOME)];
    return [self getAverageWithPredicate:predicate];
}

- (float)costWithUserOfMonth:(NSString *)month {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",month,@(BILL_TYPE_COST)];
    return [self getTotalWithPredicate:predicate];
}

- (float)incomeWithUserOfMonth:(NSString *)month {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",month,@(BILL_TYPE_INCOME)];
    return [self getTotalWithPredicate:predicate];
}

- (float)surplesWithUserOfMonth:(NSString *)month {
    NSLog(@"==========%f,%f",[self incomeOfThisMonthWithUser],[self costOfThisMonthWithUser]);
    return ([self incomeWithUserOfMonth:month] - [self costWithUserOfMonth:month]);
}

- (NSArray *)getAllSubTypesOfCostThisMonth {
    NSArray *bills = [self getAllMyCostBillOfCurrentMonth];
    if (!bills.count) return nil;
    
    NSMutableArray *subTypes = [[NSMutableArray alloc] init];
    for (Bill *bill in bills) {
        NSNumber *subtype = bill.subtype;
        if (![subTypes containsObject:subtype]) {
            [subTypes addObject:subtype];
        }
    }
    return subTypes;
}

- (NSArray *)getAllSubTypesOfIncomeThisMonth {
    NSArray *bills = [self getAllMyIncomeBillOfCurrentMonth];
    if (!bills.count) return nil;
    
    NSMutableArray *subTypes = [[NSMutableArray alloc] init];
    for (Bill *bill in bills) {
        NSNumber *subtype = bill.subtype;
        if (![subTypes containsObject:subtype]) {
            [subTypes addObject:subtype];
        }
    }
    return subTypes;
}

- (float)percentOfCostThisMonthWithSubtype:(BILL_SUBTYPE)subtype {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && subtype = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(subtype)];
    float totalMoneyOfSubtype = [self getTotalWithPredicate:predicate];
    return totalMoneyOfSubtype/[self costOfThisMonthWithUser];
}

- (float)percentOfIncomeThisMonthWithSubtype:(BILL_SUBTYPE)subtype {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && subtype = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(subtype)];
    float totalMoneyOfSubtype = [self getTotalWithPredicate:predicate];
    return totalMoneyOfSubtype/[self incomeOfThisMonthWithUser];
}

- (float)moneyOfThisMonthWithSubtype:(BILL_SUBTYPE)subtype {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && subtype = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(subtype)];
    float totalMoneyOfSubtype = [self getTotalWithPredicate:predicate];
    return totalMoneyOfSubtype;
}

- (NSArray *)getAllDatesOfCostThisMonth {
    NSArray *bills = [self getAllMyCostBillOfCurrentMonth];
    if (!bills.count) return nil;
    
    NSMutableArray *days = [[NSMutableArray alloc] init];
    for (Bill *bill in bills) {
        NSString *day = bill.day;
        if (![days containsObject:day]) {
            [days addObject:day];
        }
    }
    return days;
}

- (NSArray *)getAllDatesOfIncomeThisMonth {
    NSArray *bills = [self getAllMyIncomeBillOfCurrentMonth];
    if (!bills.count) return nil;
    
    NSMutableArray *days = [[NSMutableArray alloc] init];
    for (Bill *bill in bills) {
        NSString *day = bill.day;
        if (![days containsObject:day]) {
            [days addObject:day];
        }
    }
    return days;
}

//this year
- (float)costOfThisYearWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year = %@ && type = %@",[NSString stringToYearTranslatedFromDate:[NSDate date]],@(BILL_TYPE_COST)];
    return [self getTotalWithPredicate:predicate];
}

- (float)incomeOfThisYearWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year = %@ && type = %@",[NSString stringToYearTranslatedFromDate:[NSDate date]],@(BILL_TYPE_INCOME)];
    return [self getTotalWithPredicate:predicate];
}

- (float)averageOfCostThisYearWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year = %@ && type = %@",[NSString stringToYearTranslatedFromDate:[NSDate date]],@(BILL_TYPE_COST)];
    return [self getAverageWithPredicate:predicate];
}

- (float)averageOfIncomeThisYearWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year = %@ && type = %@",[NSString stringToYearTranslatedFromDate:[NSDate date]],@(BILL_TYPE_INCOME)];
    return [self getAverageWithPredicate:predicate];
}

- (float)surplesOfThisYearWithUser {
    return ([self incomeOfThisYearWithUser] - [self costOfThisYearWithUser]);
}

- (NSArray *)getAllMonthsOfThisYear {
    NSArray *bills = [self getAllMyBillOfThisYear];
    if (!bills.count) return nil;
    
    NSMutableArray *months = [[NSMutableArray alloc] init];
    for (Bill *bill in bills) {
        NSString *month = bill.month;
        if (![months containsObject:month]) {
            [months addObject:month];
        }
    }
    return months;
}


- (float)getTotalWithPredicate:(NSPredicate *)predicate {
    float total = 0.00;
    NSArray *bills = [self getAllMyBills];
    NSArray *filteredBills = [bills filteredArrayUsingPredicate:predicate];
    if (filteredBills.count) {
        for (Bill * obj in filteredBills) {
            total += [obj.amount floatValue];
        }
    }
    return total;
}

- (float)getAverageWithPredicate:(NSPredicate *)predicate {
    float total = 0.00;
    NSArray *bills = [self getAllMyBills];
    NSArray *filteredBills = [bills filteredArrayUsingPredicate:predicate];
    if (filteredBills.count) {
        for (Bill * obj in filteredBills) {
            total += [obj.amount floatValue];
        }
        return total/filteredBills.count;
    } else return 0.0;
}

- (NSArray *)getAllMyBills {
    NSSet *myBills = self.currentUser.myBills;
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO]];
    NSArray *bills = [myBills sortedArrayUsingDescriptors:sortDesc];
    return bills;
}

- (NSArray *)getAllMyCostBillOfCurrentMonth {
    NSSet *myBills = self.currentUser.myBills;
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES]];
    NSArray *bills = [myBills sortedArrayUsingDescriptors:sortDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(BILL_TYPE_COST)];
    NSArray *costArrs = [bills filteredArrayUsingPredicate:predicate];
    return costArrs;
}

- (NSArray *)getAllMyIncomeBillOfCurrentMonth {
    NSSet *myBills = self.currentUser.myBills;
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES]];
    NSArray *bills = [myBills sortedArrayUsingDescriptors:sortDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"month = %@ && type = %@",[NSString stringToMonthTranslatedFromDate:[NSDate date]],@(BILL_TYPE_INCOME)];
    NSArray *incomeArrs = [bills filteredArrayUsingPredicate:predicate];
    return incomeArrs;
}

- (NSArray *)getAllMyBillOfThisYear {
    NSSet *myBills = self.currentUser.myBills;
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES]];
    NSArray *bills = [myBills sortedArrayUsingDescriptors:sortDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year = %@",[NSString stringToYearTranslatedFromDate:[NSDate date]]];
    NSArray *Arrs = [bills filteredArrayUsingPredicate:predicate];
    return Arrs;
}

#pragma mark - properties

- (NSManagedObjectContext *)mainQueueContext {
    return [[CoreDataManager sharedManager] mainQueueContext];
}

- (User *)currentUser {
    NSNumber *userid = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_ID_KEY];
    if (userid) {
        return [User userWithUserId:userid inManagedObjectContext:self.mainQueueContext];
    } else return nil;
}

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)sharedManager {
    static SSFAnalysisManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:nil] init];
    });
    return manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @throw [NSException exceptionWithName:@"Alloc SSFAnalysisManager Error"
                                   reason:@"This class only can be used by [SSFAnalysisManager sharedManager]"
                                 userInfo:nil];
    return nil;
}

@end
