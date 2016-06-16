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
#import "BillTableViewCell.h"
#import "SSFMoneyTypeManager.h"
#import "NSString+Tony.h"
#import "Constants.h"
#import "User.h"

@interface SSFTodayViewController ()
@property (nonatomic, weak) IBOutlet UILabel *costLabel;
@property (nonatomic, weak) IBOutlet UILabel *incomeLabel;
@property (nonatomic, weak) IBOutlet UILabel *monthSurplesLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UILabel *monthLabel;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@end

@implementation SSFTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.currentUser.display_name;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id = %@ && month = %@",self.currentUser.user_id,[NSString stringToMonthTranslatedFromDate:[NSDate date]]];
    [self setUpFetchedResultsControllerWithPredicate:predicate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateHeadView];
}

- (void)setUpFetchedResultsControllerWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Bill"];
    request.predicate = predicate;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO]];
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.mainContext sectionNameKeyPath:@"day" cacheName:BIllFetchedResultsCacheName];
    self.fetchedResultsController = fetchedResultsController;
}

- (void)updateHeadView {
    self.costLabel.text = [NSString stringWithFormat:@"%.2f",[SSFAnalysisManager sharedManager].costOfTodayWithUser];
    self.incomeLabel.text = [NSString stringWithFormat:@"%.2f",[SSFAnalysisManager sharedManager].incomeOfTodayWithUser];
    self.monthSurplesLabel.text = [NSString stringWithFormat:@"%.2f",[SSFAnalysisManager sharedManager].surplesOfThisMonthWithUser];
    self.yearLabel.text = [NSString getTimeYearFromDate:[NSDate date]];
    self.monthLabel.text = [NSString stringWithFormat:@"%@月",[NSString getTimeMonthFromDate:[NSDate date]]];
}

#pragma mark - properties

- (User *)currentUser {
    return [SSFAnalysisManager sharedManager].currentUser;
}

- (NSManagedObjectContext *)mainContext {
    return [CoreDataManager sharedManager].mainQueueContext;
}

#pragma mark - table data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *nameString = (self.fetchedResultsController).sections[section].name;
    return [nameString componentsSeparatedByString:@" "][0];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BillTableViewCell";
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Bill *bill = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.nameLabel.text = [SSFMoneyTypeManager moneyTypeStringWithNumber:bill.subtype];
    cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",bill.amount.floatValue];
    if ((bill.type).integerValue == BILL_TYPE_COST) {
        cell.moneyLabel.textColor = [UIColor blackColor];
    } else if ((bill.type).integerValue == BILL_TYPE_INCOME) {
        cell.moneyLabel.textColor = [UIColor colorWithRed:13/255.0 green:185/255.0 blue:63/255.0 alpha:1.0];
    }
    return cell;
}

#pragma mark - action
-(IBAction)loginOut {
    [[SSFAnalysisManager sharedManager] signOut];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate showLoginAndRegisterView];
}
@end
