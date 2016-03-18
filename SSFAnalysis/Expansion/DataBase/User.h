//
//  User.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/18.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN
#define USER_USER_ID_KEY       @"user_id"

@interface User : NSManagedObject

+(User *)userWithUserId:(NSNumber *)userid inManagedObjectContext:(NSManagedObjectContext*)context;
+(User *)updateUserWithInfo:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext*)context;
+(void)deleteUserWithUserId:(NSNumber *)userid inManagedObjectContext:(NSManagedObjectContext*)context;

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
