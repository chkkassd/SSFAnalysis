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
#define BILL_BILL_ID_KEY  @"bill_id"
#define BILL_USER_ID_KEY @"user_id"
#define BILL_AMOUNT_KEY @"amount"
#define BILL_TYPE_KEY @"type"
#define BILL_SUBTYPE_KEY @"subtype"
#define BILL_TIME_KEY @"time"
#define BILL_REMARK_KEY @"remark"
#define BILL_OWNER_KEY @"owner"

@interface Bill : NSManagedObject

+(Bill *)billWithBillId:(NSString *)billid inManagedObjectContext:(NSManagedObjectContext*)context;
+(Bill *)updateBillWithInfo:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END

#import "Bill+CoreDataProperties.h"
