//
//  SSFMainTabBarViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFMainTabBarViewController.h"
#import "Reachability.h"
#import "SSFTodayViewController.h"

@interface SSFMainTabBarViewController ()
@property (NS_NONATOMIC_IOSONLY, strong) SSFTodayViewController *todayViewController;
@property (NS_NONATOMIC_IOSONLY, strong) Reachability *reach;
@end

@implementation SSFMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkNetworkReachability];
}

- (SSFTodayViewController *)todayViewController {
    if (!_todayViewController) {
        UINavigationController *nav = self.viewControllers[0];
        _todayViewController = nav.viewControllers[0];
    }
    return _todayViewController;
}

#pragma mark - Reachability

- (void)checkNetworkReachability {
     self.reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    __weak __block typeof (self) weakSelf = self;
    //Reachable block
    self.reach.reachableBlock = ^(Reachability *reach){
        
        //This is called on background thread,so we should update UI on a main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.todayViewController.titleString = @"";
        });
    };
    
    //Unreachable block
    self.reach.unreachableBlock = ^(Reachability *reach){
        
        //This is called on background thread,so we should update UI on a main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.todayViewController.titleString = @"(未连接)";
        });
    };
    
    [self.reach startNotifier];
}
@end
