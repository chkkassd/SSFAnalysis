//
//  CZSShowSimpleAlert.h
//  Chat
//
//  Created by 赛峰 施 on 15/8/17.
//  Copyright (c) 2015年 CZS Team 2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CZSShowSimpleAlert : NSObject

+ (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message controller:(UIViewController *)controller;

@end
