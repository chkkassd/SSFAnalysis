//
//  User.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/18.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "User.h"
static NSString * const USER_USER_ID_KEY = @"user_id";

@implementation User

+(User *)userWithUserId:(NSNumber *)userid inManagedObjectContext:(NSManagedObjectContext *)context {
    User *obj = nil;
    if (userid.integerValue > 0) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"user_id = %@",userid];
        request.sortDescriptors = nil;
        
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results || results.count > 1) {
            //error
        } else if (results.count == 1) {
            obj = results[0];
        }
    }
    return obj;
}

+(User *)updateUserWithInfo:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)context {
    User *obj = nil;
    NSNumber *userid = info[USER_USER_ID_KEY];
    if (userid.integerValue > 0) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"user_id = %@",userid];
        request.sortDescriptors = nil;
        
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results || results.count > 1) {
            // error
        } else if (results.count == 0) {
            obj = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
            obj.user_id = userid;
        } else {
            obj = results.firstObject;
        }
        [obj setValuesForKeysWithDictionary:info];
    }
    return obj;
}

+(void)deleteUserWithUserId:(NSNumber *)userid inManagedObjectContext:(NSManagedObjectContext *)context {
    User *obj = [User userWithUserId:userid inManagedObjectContext:context];
    if (obj) {
        [context deleteObject:obj];
    }
}

#pragma mark - kvc
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"User model have undefined key");
    [super setValue:value forKey:key];
}

@end
