//
//  SSFLoginViewController.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/16.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSFLoginViewControllerDelegate;
@interface SSFLoginViewController : UIViewController
@property (nonatomic, weak) id <SSFLoginViewControllerDelegate> delegate;
@end

@protocol SSFLoginViewControllerDelegate <NSObject>

- (void)SSFLoginViewControllerDidSignInWithController:(SSFLoginViewController *)controller;

@end