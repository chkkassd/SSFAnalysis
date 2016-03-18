//
//  User+CoreDataProperties.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/18.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *user_id;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *display_name;

@end

NS_ASSUME_NONNULL_END
