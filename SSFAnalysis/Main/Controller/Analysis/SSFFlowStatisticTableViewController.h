//
//  SSFFlowStatisticTableViewController.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/6/2.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowStatisticTableViewCell.h"
#import "NSString+Tony.h"
#import "SSFAnalysisManager.h"
#import "FlowStatisticModel.h"

@interface SSFFlowStatisticTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
