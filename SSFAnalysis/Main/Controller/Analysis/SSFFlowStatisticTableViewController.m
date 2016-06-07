//
//  SSFFlowStatisticTableViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/6/2.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFFlowStatisticTableViewController.h"
#import "SSFFlowStatisticTableViewController+Handler.h"

@interface SSFFlowStatisticTableViewController()
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end

@implementation SSFFlowStatisticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureHeadView];
    [self configureTableViewData];
}

- (void)configureHeadView {
    self.yearLabel.text = [NSString stringToYearTranslatedFromDate:[NSDate date]];
    self.incomeLabel.text = [NSString stringWithFormat:@"%.2f",[[SSFAnalysisManager sharedManager] incomeOfThisYearWithUser]];
    self.costLabel.text = [NSString stringWithFormat:@"%.2f",[[SSFAnalysisManager sharedManager] costOfThisYearWithUser]];
    self.surplusLabel.text = [NSString stringWithFormat:@"%.2f",[[SSFAnalysisManager sharedManager] surplesOfThisYearWithUser]];
}

#pragma mark - properties

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    [self.tableView reloadData];
}

#pragma mark - table datasource

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlowStatisticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlowStatisticTableViewCell" forIndexPath:indexPath];
    FlowStatisticModel *model = self.dataArr[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}
@end
