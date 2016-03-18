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

@interface AppDelegate ()<SSFLoginViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSNumber *userid = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_ID_KEY];
    if (!userid) {
        //show login
        [self showLoginAndRegisterView];
    } else {
        [[CoreDataManager sharedManager] startConnectCoreData];
    }
    return YES;
}

#pragma mark - SSFLoginViewControllerDelegate

- (void)SSFLoginViewControllerDidSignInWithController:(SSFLoginViewController *)controller {
    [self showMainView];
}

@end
