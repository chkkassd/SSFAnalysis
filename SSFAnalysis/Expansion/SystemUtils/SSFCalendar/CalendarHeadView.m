//
//  CalendarHeadView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/5/13.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "CalendarHeadView.h"

@implementation CalendarHeadView

- (IBAction)pageUp:(id)sender {
    [self.delegate CalendarHeadView:self didSelectWithPageKind:PageKindUp];
}

- (IBAction)pageDown:(id)sender {
    [self.delegate CalendarHeadView:self didSelectWithPageKind:PageKindDown];
}

@end
