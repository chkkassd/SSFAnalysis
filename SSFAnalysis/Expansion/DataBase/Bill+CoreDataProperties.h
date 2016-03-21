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
#import "User+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface Bill (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *user_id;
@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSNumber *subtype;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSString *bill_id;
@property (nullable, nonatomic, retain) User *owner;

@end

NS_ASSUME_NONNULL_END
