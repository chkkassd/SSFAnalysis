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
    self.minimumLineSpacing = 0.0;
    self.minimumInteritemSpacing = 0.0;
    CGFloat cellWidth = self.calendarView.frame.size.width/7;
    self.itemSize = CGSizeMake(cellWidth, cellWidth);
}

//设置了item之间的最大间距也为0
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 0;
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width <= self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForItemAtIndexPath:indexPath];
//}
@end
