//
//  Bill+CoreDataProperties.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/21.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Bill.h"

@class User;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(unsigned int, BILL_TYPE) {
    BILL_TYPE_COST = 0,
    BILL_TYPE_INCOME = 1
};

typedef NS_ENUM(unsigned int, BILL_SUBTYPE) {
    BILL_SUBTYPE_EAT = 0,
    BILL_SUBTYPE_TRAFFIC = 1,
    BILL_SUBTYPE_CLOTHES = 2,
    BILL_SUBTYPE_STAY = 3,
    BILL_SUBTYPE_ENTERTAINMENT = 4,
    BILL_SUBTYPE_SHOPPING = 5,
    BILL_SUBTYPE_OTHERCOST = 6,
    BILL_SUBTYPE_SALARY = 7,
    BILL_SUBTYPE_INVESTMENT = 8,
    BILL_SUBTYPE_PART_TIME_JOB = 9
};

@interface Bill (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *user_id;
@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *type;//cost or income
@property (nullable, nonatomic, retain) NSNumber *subtype;//cost or income detail
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSString *bill_id;
@property (nullable, nonatomic, retain) NSString *day;//2015-03-07
@property (nullable, nonatomic, retain) NSString *month;//2015-03
@property (nullable, nonatomic, retain) NSString *year;//2015
@property (nullable, nonatomic, retain) User *owner;

@end

NS_ASSUME_NONNULL_END
