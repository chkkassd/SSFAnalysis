//
//  SSFAnalysisChartTableViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/4/15.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFAnalysisChartTableViewController.h"
#import "SSFLineChartView.h"

@interface SSFAnalysisChartTableViewController ()
@property (weak, nonatomic) IBOutlet SSFLineChartView *lineChartView;

@end

@implementation SSFAnalysisChartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Cost];
}

- (IBAction)segmentPressed:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Cost];
            break;
        case 1:
            [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Income];
            break;
        default:
            break;
    }
}

@end
