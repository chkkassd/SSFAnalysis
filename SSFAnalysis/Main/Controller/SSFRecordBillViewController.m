//
//  SSFRecordBillViewController.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/24.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFRecordBillViewController.h"
#import "OptionCollectionViewCell.h"
#import "SSFAnalysisManager.h"
#import "CoreDataManager.h"
#import "SSFMoneyTypeManager.h"
#import "NSString+Tony.h"

@interface SSFRecordBillViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) NSNumber *subTypeNumber;
@end

@implementation SSFRecordBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    self.options = @[@"吃饭",@"交通",@"服饰",@"住宿",@"娱乐",@"购物",@"其他支出"];//@[@"工资",@"投资",@"兼职"];
}

#pragma mark - properties

- (User *)currentUser {
    return [SSFAnalysisManager sharedManager].currentUser;
}

- (NSManagedObjectContext *)mainContext {
    return [CoreDataManager sharedManager].mainQueueContext;
}

#pragma mark - action

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    self.subTypeNumber = nil;
    self.descriptionLabel.text = @"";
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.options = @[@"吃饭",@"交通",@"服饰",@"住宿",@"娱乐",@"购物",@"其他支出"];
            break;
        case 1:
            self.options = @[@"工资",@"投资",@"兼职"];
            break;

        default:
            break;
    }
    [self.collectionView reloadData];
}

- (IBAction)recordButtonPressed:(id)sender {
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSDate *now = [NSDate date];
    NSString *dayString = [NSString stringToDayTranslatedFromDate:now];
    NSString *monthString = [NSString stringToMonthTranslatedFromDate:now];
    NSString *yearString = [NSString stringToYearTranslatedFromDate:now];
    NSDictionary *info = @{BILL_AMOUNT_KEY:@([self.textField.text floatValue]),
                           BILL_BILL_ID_KEY:uuid,
                           BILL_REMARK_KEY:self.remarkTextField.text,
                           BILL_SUBTYPE_KEY:self.subTypeNumber,
                           BILL_TIME_KEY:now,
                           BILL_TYPE_KEY:@(self.segment.selectedSegmentIndex),
                           BILL_USER_ID_KEY:self.currentUser.user_id,
                           BILL_DAY_KEY:dayString,
                           BILL_MONTH_KEY:monthString,
                           BILL_YEAR_KEY:yearString,
                           BILL_OWNER_KEY:self.currentUser
                           };
    [Bill updateBillWithInfo:info inManagedObjectContext:self.mainContext];
    [self.mainContext save:NULL];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - collection data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.options.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OptionCollectionViewCell";
    OptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.optionNameLabel.text = self.options[indexPath.row];
    return cell;
}

#pragma mark - collection delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.descriptionLabel.text = self.options[indexPath.row];
    self.subTypeNumber = [SSFMoneyTypeManager numberWithMoneyTypeString:self.options[indexPath.row]];
}
@end
