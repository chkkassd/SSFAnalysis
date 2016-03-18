//
//  AppDelegate+ShowLoginOrMain.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/18.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "AppDelegate+ShowLoginOrMain.h"
#import "SSFLoginViewController.h"
#import "SSFMainTabBarViewController.h"

@implementation AppDelegate (ShowLoginOrMain)

- (void)showLoginAndRegisterView {
    SSFLoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SSFLoginViewController"];
    vc.delegate = self;
    self.window.rootViewController = vc;
}

- (void)showMainView {
    SSFMainTabBarViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SSFMainTabBarViewController"];
    self.window.rootViewController = vc;
}
@end
