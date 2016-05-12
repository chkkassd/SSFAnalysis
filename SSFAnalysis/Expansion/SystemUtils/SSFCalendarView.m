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

@interface SSFCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *daysOfMonth;//某月所有天数数据源，包括第一周空出的天数
@property (nonatomic, strong) NSDate *dateOfMonth;//某月的某一日起的date
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
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)configureView {
    self.dateOfMonth = [NSDate date];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CalendarCollectionViewCell"];
    [self addSubview:self.collectionView];
}

- (void)setDateOfMonth:(NSDate *)dateOfMonth {
    _dateOfMonth = dateOfMonth;
    [self calculateDaysOfMonthWithDate:_dateOfMonth];
}

- (void)calculateDaysOfMonthWithDate:(NSDate *)date {
    NSUInteger allDays = [self numberOfMonthForDate:date];
    NSUInteger firstDay = [self weeklyOrdinalityForDate:[self firstDayOfMonthForDate:date]];
    NSUInteger count = allDays + firstDay;
    self.daysOfMonth = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        if (i < firstDay) {
            [self.daysOfMonth insertObject:@"" atIndex:i];
        } else {
            [self.daysOfMonth insertObject:[NSString stringWithFormat:@"%lu",i - firstDay + 1] atIndex:i];
        }
    }
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.daysOfMonth.count;//([self numberOfMonthForDate:[NSDate date]] + [self weeklyOrdinalityForDate:[NSDate date]]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCollectionViewCell" forIndexPath:indexPath];
    [cell configureWithData:self.daysOfMonth[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
