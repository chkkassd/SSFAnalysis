//
//  SSFPieChartView.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/23.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSFPieChartView : UIView
- (instancetype)initWithFrame:(CGRect)frame withModel:(NSArray *)modelArr;
- (void)drawSubregionWithModel:(NSArray *)modelArr;
@end
