//
//  CZSShowSimpleAlert.m
//  Chat
//
//  Created by 赛峰 施 on 15/8/17.
//  Copyright (c) 2015年 CZS Team 2015. All rights reserved.
//

#import "CZSShowSimpleAlert.h"

#define CurrentSystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation CZSShowSimpleAlert

+ (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message controller:(UIViewController *)controller {
    if (CurrentSystemVersion < 8.0) {
        //ios8以下uialert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定"otherButtonTitles: nil];
        [alert show];
    } else {
        //iOS8以后uialertcontroller
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [controller presentViewController:alertController animated:YES completion:NULL];
    }
}

@end
