//
//  SSFLoginViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/16.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFLoginViewController.h"
#import "SSFLoginView.h"

@interface SSFLoginViewController ()

@end

@implementation SSFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SSFLoginView *loginView = [[SSFLoginView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:loginView];
}


@end
