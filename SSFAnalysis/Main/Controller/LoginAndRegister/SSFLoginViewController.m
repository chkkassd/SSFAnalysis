//
//  SSFLoginViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/16.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFLoginViewController.h"
#import "SSFLoginView.h"
#import "SSFAnalysisManager.h"
#import "AppDelegate+ShowLoginOrMain.h"

@interface SSFLoginViewController ()

@end

@implementation SSFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Action
- (IBAction)registerButtonPressed:(id)sender {
    __weak typeof(self) weakSelf = self;
    SSFLoginView *loginView = [[SSFLoginView alloc] initWithFrame:self.view.frame signType:SSFLoginViewSignUp loginHandler:^{
        [weakSelf.delegate SSFLoginViewControllerDidSignInWithController:self];
    }];
    [self.view addSubview:loginView];
}

- (IBAction)loginButtonPressed:(id)sender {
    __weak typeof(self) weakSelf = self;
    SSFLoginView *loginView = [[SSFLoginView alloc] initWithFrame:self.view.frame signType:SSFLoginViewSignIn loginHandler:^{
        [weakSelf.delegate SSFLoginViewControllerDidSignInWithController:self];
    }];
    [self.view addSubview:loginView];
}

@end
