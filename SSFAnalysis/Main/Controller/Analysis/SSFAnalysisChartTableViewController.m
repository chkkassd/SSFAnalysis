//
//  SSFAnalysisChartTableViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/4/15.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFAnalysisChartTableViewController.h"
#import "SSFAnalysisChartTableViewController+Handler.h"
#import "SSFLineChartView.h"
#import "SSFPieChartView.h"

@interface SSFAnalysisChartTableViewController ()
@property (weak, nonatomic) IBOutlet SSFLineChartView *lineChartView;
@property (strong, nonatomic) SSFPieChartView *pieChartView;

@end

@implementation SSFAnalysisChartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Cost];
    
    [self configureCostPieChartData];
    self.pieChartView = [[SSFPieChartView alloc] initWithFrame:CGRectMake(0, self.lineChartView.frame.origin.y + self.lineChartView.frame.size.height + 50, self.view.frame.size.width, self.lineChartView.frame.size.height + 50) withModel:self.pieChartData];
    [self.tableView.tableHeaderView addSubview:self.pieChartView];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.tableView.tableHeaderView.frame.size.width, self.pieChartView.frame.origin.y + self.pieChartView.frame.size.height);
}

- (IBAction)segmentPressed:(UISegmentedControl *)sender {

    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Cost];
            [self configureCostPieChartData];
            [self.pieChartView drawSubregionWithModel:self.pieChartData];
            break;
        case 1:
            [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Income];
            [self configureIncomePieChartData];
            [self.pieChartView drawSubregionWithModel:self.pieChartData];
            break;
        default:
            break;
    }
}

@end
