//
//  SSFAnalysisManager.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface SSFAnalysisManager : NSObject

- (void)userLoginAndSaveWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void(^)(NSString *description,BOOL success))handler;
- (void)signOut;

@property (nonatomic, strong) User *currentUser;
+ (instancetype)sharedManager;
@end
