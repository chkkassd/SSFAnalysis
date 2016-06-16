//
//  SSFPieChartView.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/23.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSFPieChartView : UIView
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame withModel:(NSArray *)modelArr NS_DESIGNATED_INITIALIZER;
- (void)drawSubregionWithModel:(NSArray *)modelArr;
@end
