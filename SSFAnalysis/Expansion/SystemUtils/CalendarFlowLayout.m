//
//  CalendarFlowLayout.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/12.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "CalendarFlowLayout.h"

@interface CalendarFlowLayout()
@property (nonatomic, weak) SSFCalendarView *calendarView;
@end

@implementation CalendarFlowLayout

- (instancetype)initWithCalendarView:(SSFCalendarView *)view {
    self = [super init];
    if (self) {
        self.calendarView = view;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat cellWidth = self.calendarView.frame.size.width/7;
    self.itemSize = CGSizeMake(cellWidth, cellWidth);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}
@end
