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

#pragma mark - about data

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

- (float)costOfThisYearWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year = %@ && type = %@",[NSString stringToYearTranslatedFromDate:[NSDate date]],@(BILL_TYPE_COST)];
    return [self getTotalWithPredicate:predicate];
}

- (float)incomeOfThisYearWithUser {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year = %@ && type = %@",[NSString stringToYearTranslatedFromDate:[NSDate date]],@(BILL_TYPE_INCOME)];
    return [self getTotalWithPredicate:predicate];
}

- (float)surplesOfThisYearWithUser {
    return ([self incomeOfThisYearWithUser] - [self costOfThisYearWithUser]);
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

- (NSArray *)getAllMyBills {
    NSSet *myBills = self.currentUser.myBills;
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO]];
    NSArray *bills = [myBills sortedArrayUsingDescriptors:sortDesc];
    return bills;
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
