//
//  SSFTodayViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/18.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFTodayViewController.h"
#import "SSFAnalysisManager.h"
#import "AppDelegate+ShowLoginOrMain.h"

@interface SSFTodayViewController ()

@end

@implementation SSFTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [SSFAnalysisManager sharedManager].currentUser.display_name;
}

- (IBAction)signOut:(id)sender {
    [[SSFAnalysisManager sharedManager] signOut];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate showLoginAndRegisterView];
}

@end
