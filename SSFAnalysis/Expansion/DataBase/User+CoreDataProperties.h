//
//  User+CoreDataProperties.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/21.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Bill+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *user_id;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *display_name;
@property (nullable, nonatomic, retain) NSString *account;
@property (nullable, nonatomic, retain) NSString *country_code;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSSet<Bill *> *myBills;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMyBillsObject:(Bill *)value;
- (void)removeMyBillsObject:(Bill *)value;
- (void)addMyBills:(NSSet<Bill *> *)values;
- (void)removeMyBills:(NSSet<Bill *> *)values;

@end

NS_ASSUME_NONNULL_END
