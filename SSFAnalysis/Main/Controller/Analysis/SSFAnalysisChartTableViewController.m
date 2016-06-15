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
#import "AnalysisChartTableViewCell.h"
#import "SSFRecordBillViewController.h"
#import "Bill+CoreDataProperties.h"


@interface SSFAnalysisChartTableViewController ()
@property (strong, nonatomic) SSFLineChartView *lineChartView;
@property (strong, nonatomic) SSFPieChartView *pieChartView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation SSFAnalysisChartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotification:) name:DefaultRecordSuccessNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DefaultRecordSuccessNotification object:nil];
}

static const NSInteger DefaultMargin = 10;
static const CGFloat DefaultWidthHeightRatio =1.8;

- (void)configureViews {
    //构建折线图
    self.lineChartView = [[SSFLineChartView alloc] initWithFrame:CGRectMake(DefaultMargin, 37, self.view.frame.size.width - DefaultMargin*2, (self.view.frame.size.width - DefaultMargin*2)/DefaultWidthHeightRatio)];
    self.lineChartView.layer.cornerRadius = 6.0f;
    [self.tableView.tableHeaderView addSubview:self.lineChartView];
    [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Cost];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, self.lineChartView.frame.origin.y + self.lineChartView.frame.size.height + DefaultMargin, 52, 21)];
    label.text = @"占比图";
    label.textColor = [UIColor darkGrayColor];
    [self.tableView.tableHeaderView addSubview:label];
    
    //构建圆饼图
    [self configureCostPieChartData];
    self.pieChartView = [[SSFPieChartView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y + label.frame.size.height + DefaultMargin, self.view.frame.size.width, self.lineChartView.frame.size.height) withModel:self.pieChartData];
    [self.tableView.tableHeaderView addSubview:self.pieChartView];
    
    //构建tableHeaderView
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.tableView.tableHeaderView.frame.size.width, self.pieChartView.frame.origin.y + self.pieChartView.frame.size.height);
}

- (IBAction)segmentPressed:(UISegmentedControl *)sender {

    switch (sender.selectedSegmentIndex) {
        case 0:
            [self drawChartCost];
            break;
        case 1:
            [self drawChartIncome];
            break;
        default:
            break;
    }
}

- (void)drawChartCost {
    [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Cost];
    [self configureCostPieChartData];
    [self.pieChartView drawSubregionWithModel:self.pieChartData];
    [self.tableView reloadData];
}

- (void)drawChartIncome {
    [self.lineChartView drawLineChartWithMonth:0 chartType:LineChartType_Income];
    [self configureIncomePieChartData];
    [self.pieChartView drawSubregionWithModel:self.pieChartData];
    [self.tableView reloadData];
}

#pragma mark - notification

- (void)reciveNotification:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    NSInteger type = [userInfo[BILL_TYPE_KEY] integerValue];
    if (type == BILL_TYPE_COST) {
        if (self.segment.selectedSegmentIndex == BILL_TYPE_COST) {
            [self drawChartCost];
        }
    } else if (type == BILL_TYPE_INCOME) {
        if (self.segment.selectedSegmentIndex == BILL_TYPE_INCOME) {
            [self drawChartIncome];
        }
    }
}

#pragma mark - table datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pieChartData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnalysisChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnalysisChartTableViewCell" forIndexPath:indexPath];
    PieChartModel *model = self.pieChartData[indexPath.row];
    [cell configureTableViewCellwithModel:model];
    
    return cell;
}
@end
