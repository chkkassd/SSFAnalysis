//
//  SSFGravityCollisionBehavior.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/17.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFGravityCollisionBehavior.h"

@implementation SSFGravityCollisionBehavior

- (instancetype)initWithItems:(NSArray *)items refrenceView:(UIView *)refrenceView {
    self = [super init];
    if (self) {
        NSLog(@".....%@",NSStringFromCGRect(refrenceView.frame));
        
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:items];
        gravityBehavior.angle = 0.45*M_PI;
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
        [collisionBehavior addBoundaryWithIdentifier:@"ddd" fromPoint:CGPointMake(0, refrenceView.frame.size.height*5/12) toPoint:CGPointMake(refrenceView.frame.size.width, refrenceView.frame.size.height*5/12)];
        UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:items];
//        itemBehavior.allowsRotation = YES;
        itemBehavior.elasticity = 0;
        [itemBehavior addAngularVelocity:-0.1 forItem:items[0]];
        
        [self addChildBehavior:itemBehavior];
        [self addChildBehavior:gravityBehavior];
        [self addChildBehavior:collisionBehavior];
    }
    return self;
}

@end
