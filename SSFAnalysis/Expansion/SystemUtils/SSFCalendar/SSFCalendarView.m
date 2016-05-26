//
//  SSFCalendarView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFCalendarView.h"
#import "NSDate+Calendar.h"
#import "CalendarCollectionViewCell.h"
#import "CalendarFlowLayout.h"
#import "NSString+Tony.h"
#import "CalendarHeadView.h"

@interface SSFCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CalendarHeadViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *daysOfMonth;//某月所有天数数据源，包括第一周空出的天数和周日到周六的表头
@property (nonatomic, strong) NSDate *dateOfMonth;//某月的某一日期的date
@end

@implementation SSFCalendarView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CalendarFlowLayout *flowLayout = [[CalendarFlowLayout alloc] initWithCalendarView:self];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)configureView {
    self.dateOfMonth = [NSDate date];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CalendarCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarHeadView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeadView"];
    [self addSubview:self.collectionView];
}

- (void)setDateOfMonth:(NSDate *)dateOfMonth {
    _dateOfMonth = dateOfMonth;
    [self calculateDaysOfMonthWithDate:_dateOfMonth];
}

- (void)calculateDaysOfMonthWithDate:(NSDate *)date {
    NSUInteger allDays = [self numberOfMonthForDate:date];
    NSUInteger firstDay = [self weeklyOrdinalityForDate:[self firstDayOfMonthForDate:date]];
    NSUInteger count = allDays + firstDay - 1;
    self.daysOfMonth = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        if (i < firstDay - 1) {
            [self.daysOfMonth insertObject:@"" atIndex:i];
        } else {
            [self.daysOfMonth insertObject:[NSString stringWithFormat:@"%lu",i - firstDay + 2] atIndex:i];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - fetch data of month

//这个月一共几天
- (NSUInteger)numberOfMonthForDate:(NSDate *)date {
    return [date numberOfDayInCurrentMonth];
}

//这个月第一天
- (NSDate *)firstDayOfMonthForDate:(NSDate *)date {
    return [date firstDayOfCurrentMonth];
}

//这个月第一天是周几
- (NSUInteger)weeklyOrdinalityForDate:(NSDate *)date {
    return [date weeklyOrdinality];
}

//获取上个月1号date
- (NSDate *)getLastMonth {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:self.dateOfMonth];
    
    NSInteger currentYear = [currentComps year];
    NSInteger currentMonth = [currentComps month];
    if (currentMonth <= 1) {
        currentYear-=1;
        currentMonth = 12;
    } else {
        currentMonth-=1;
    }
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:currentYear];
    [resultComps setMonth:currentMonth];
    [resultComps setDay:1];
    
    return [currentCalendar dateFromComponents:resultComps];
}

//获取下个月1号date
- (NSDate *)getNextMonth {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:self.dateOfMonth];
    
    NSInteger currentYear = [currentComps year];
    NSInteger currentMonth = [currentComps month];
    if (currentMonth >= 12) {
        currentYear+=1;
        currentMonth = 1;
    } else {
        currentMonth+=1;
    }
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:currentYear];
    [resultComps setMonth:currentMonth];
    [resultComps setDay:1];
    
    return [currentCalendar dateFromComponents:resultComps];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.daysOfMonth.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCollectionViewCell" forIndexPath:indexPath];
    [cell configureWithData:self.daysOfMonth[indexPath.row] monthYear:[NSString stringToMonthTranslatedFromDate:self.dateOfMonth]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CalendarHeadView *headerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeadView" forIndexPath:indexPath];
        headerView.delegate = self;
        headerView.timeTitleLabel.text = [NSString stringToMonthTranslatedFromDate:self.dateOfMonth];
    }
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, 70);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedTimeString = [[NSString stringToMonthTranslatedFromDate:self.dateOfMonth] stringByAppendingString:[NSString stringWithFormat:@"-%@",self.daysOfMonth[indexPath.row]]];
    [self.delegate SSFCalendarView:self didSelectTime:[NSString convertDateToDayFromString:selectedTimeString]];
}

#pragma mark - CalendarHeadViewDelegeta

- (void)CalendarHeadView:(CalendarHeadView *)calendarView didSelectWithPageKind:(PageKind)kind {
    if (kind == PageKindUp) {
        //上个月
        self.dateOfMonth = [self getLastMonth];
    } else if (kind == PageKindDown) {
        //下个月
        self.dateOfMonth = [self getNextMonth];
    }
}
@end
