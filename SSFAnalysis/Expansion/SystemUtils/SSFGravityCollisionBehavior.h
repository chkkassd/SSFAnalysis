//
//  SSFGravityCollisionBehavior.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSFGravityCollisionBehavior : UIDynamicBehavior
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithItems:(NSArray *)items refrenceView:(UIView *)refrenceView NS_DESIGNATED_INITIALIZER;
@end
