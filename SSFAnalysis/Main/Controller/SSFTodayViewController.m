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
#import "Bill+CoreDataProperties.h"
#import "CoreDataManager.h"

@interface SSFTodayViewController ()
@property (nonatomic, weak) IBOutlet UILabel *costLabel;
@property (nonatomic, weak) IBOutlet UILabel *incomeLabel;
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

- (IBAction)test:(id)sender {
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSDictionary *info = @{BILL_AMOUNT_KEY:@(100),
                           BILL_BILL_ID_KEY:uuid,
                           BILL_REMARK_KEY:@"dd",
                           BILL_SUBTYPE_KEY:@(1),
                           BILL_TIME_KEY:[NSDate date],
                           BILL_TYPE_KEY:@(2),
                           BILL_USER_ID_KEY:[SSFAnalysisManager sharedManager].currentUser.user_id
                           };
    Bill *bill = [Bill updateBillWithInfo:info inManagedObjectContext:[CoreDataManager sharedManager].mainQueueContext];
    [[SSFAnalysisManager sharedManager].currentUser addMyBillsObject:bill];
    [[CoreDataManager sharedManager].mainQueueContext save:NULL];
    self.costLabel.text = [NSString stringWithFormat:@"%d",[SSFAnalysisManager sharedManager].currentUser.myBills.count];
    self.incomeLabel.text = [Bill billWithBillId:uuid inManagedObjectContext:[CoreDataManager sharedManager].mainQueueContext].owner.display_name;
}

@end
