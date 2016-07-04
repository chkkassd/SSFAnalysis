//
//  AppDelegate.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/2/26.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+ShowLoginOrMain.h"
#import "SSFLoginViewController.h"
#import "CoreDataManager.h"
#import "Constants.h"
#import "Growing.h"

@interface AppDelegate ()<SSFLoginViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Growing startWithAccountId:@"b1bbe8bc60ad14e5"];//growing
    
    NSNumber *userid = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserIdKey];
    if (!userid) {
        //show login
        [self showLoginAndRegisterView];
    } else {
        [[CoreDataManager sharedManager] startConnectCoreData];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //growing
    if ([Growing handleUrl:url]) // 请务必确保该函数被调用
    {
        return YES;
    }
    return NO;
}

#pragma mark - SSFLoginViewControllerDelegate

- (void)SSFLoginViewControllerDidSignInWithController:(SSFLoginViewController *)controller {
    [self showMainView];
}

@end
