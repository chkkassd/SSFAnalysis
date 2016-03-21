//
//  Bill.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/21.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "Bill.h"

@implementation Bill

+ (Bill *)billWithBillId:(NSString *)billid inManagedObjectContext:(NSManagedObjectContext *)context {
    Bill *obj = nil;
    if (billid.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Bill"];
        request.predicate = [NSPredicate predicateWithFormat:@"bill_id = %@",billid];
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

+ (Bill *)updateBillWithInfo:(NSDictionary *)info inManagedObjectContext:(NSManagedObjectContext *)context {
    Bill *obj = nil;
    NSString *billid = [info objectForKey:BILL_BILL_ID_KEY];
    if ([billid integerValue] > 0) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Bill"];
        request.predicate = [NSPredicate predicateWithFormat:@"bill_id = %@",billid];
        request.sortDescriptors = nil;
        
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results || [results count] > 1) {
            // error
        } else if ([results count] == 0) {
            obj = [NSEntityDescription insertNewObjectForEntityForName:@"Bill" inManagedObjectContext:context];
            obj.bill_id = billid;
        } else {
            obj = [results firstObject];
        }
        [obj setValuesForKeysWithDictionary:info];
    }
    return obj;
}

#pragma mark - kvc
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"User model have undefined key");
    [super setValue:value forKey:key];
}

@end
