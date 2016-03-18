//
//  SSFAnalysisManager.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFAnalysisManager.h"
#import "SSFNetWork.h"
#import "CoreDataManager.h"

@interface SSFAnalysisManager()
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainQueueContext;
@end

@implementation SSFAnalysisManager

-(void)userLoginAndSaveWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void (^)(NSString *,BOOL))handler {
    [[SSFNetWork sharedNetWork] signInWithEmail:email password:password completion:^(NSString *obj, NSData *resumeData) {
        if (obj) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:[obj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",resultDic);
            if ([resultDic[@"response_code"] integerValue] == 100 ) {
                //do save operation
                NSDictionary *userDic = resultDic[@"user"];
                [[CoreDataManager sharedManager] startConnectCoreData];
                [User updateUserWithInfo:userDic inManagedObjectContext:self.mainQueueContext];
                [self.mainQueueContext save:NULL];
                [[NSUserDefaults standardUserDefaults] setObject:userDic[@"user_id"] forKey:LOGIN_USER_ID_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
                handler(nil,YES);
            } else {
                handler(@"登录失败，稍后再试",NO);
            }
        } else {
            handler(@"网络异常，稍后再试",NO);
        }
    }];
}

- (void)signOut {
    [[CoreDataManager sharedManager] stopConnectCoreData];
    [[NSUserDefaults standardUserDefaults] setObject:NULL forKey:LOGIN_USER_ID_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - properties

- (NSManagedObjectContext *)mainQueueContext {
    return [[CoreDataManager sharedManager] mainQueueContext];
}

- (User *)currentUser {
    NSNumber *userid = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_ID_KEY];
    if (userid) {
        return [User userWithUserId:userid inManagedObjectContext:self.mainQueueContext];
    } else return nil;
}

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)sharedManager {
    static SSFAnalysisManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:nil] init];
    });
    return manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @throw [NSException exceptionWithName:@"Alloc SSFAnalysisManager Error"
                                   reason:@"This class only can be used by [SSFAnalysisManager sharedManager]"
                                 userInfo:nil];
    return nil;
}

@end
