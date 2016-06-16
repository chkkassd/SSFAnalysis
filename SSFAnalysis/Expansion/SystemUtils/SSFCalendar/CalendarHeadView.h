//
//  CalendarHeadView.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/13.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(unsigned int, PageKind) {
    PageKindUp,
    PageKindDown
};

@protocol CalendarHeadViewDelegate;
@interface CalendarHeadView : UICollectionReusableView
@property (nonatomic, weak) IBOutlet UILabel *timeTitleLabel;
@property (nonatomic, weak) id <CalendarHeadViewDelegate> delegate;
@end

@protocol CalendarHeadViewDelegate <NSObject>

- (void)CalendarHeadView:(CalendarHeadView *)calendarView didSelectWithPageKind:(PageKind)kind;

@end