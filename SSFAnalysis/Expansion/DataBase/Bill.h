//
//  Bill.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/21.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const BILL_BILL_ID_KEY;
extern NSString *const BILL_USER_ID_KEY;
extern NSString *const BILL_AMOUNT_KEY;
extern NSString *const BILL_TYPE_KEY;
extern NSString *const BILL_SUBTYPE_KEY;
extern NSString *const BILL_TIME_KEY;
extern NSString *const BILL_REMARK_KEY;
extern NSString *const BILL_DAY_KEY;
extern NSString *const BILL_MONTH_KEY;
extern NSString *const BILL_YEAR_KEY;
extern NSString *const BILL_OWNER_KEY;

@interface Bill : NSManagedObject

+(Bill *)billWithBillId:(NSString *)billid inManagedObjectContext:(NSManagedObjectContext*)context;
+(Bill *)updateBillWithInfo:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext*)context;
+(void)deleteBillWithBillId:(NSString *)billid inManagedObjectContext:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END

#import "Bill+CoreDataProperties.h"
