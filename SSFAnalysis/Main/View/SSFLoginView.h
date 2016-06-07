//
//  SSFLoginView.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/16.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginHandler)(void);

typedef NS_ENUM(NSInteger,SignType) {
    SSFLoginViewSignIn = 0,
    SSFLoginViewSignUp = 1
};

@interface SSFLoginView : UIView
- (instancetype)initWithFrame:(CGRect)frame signType:(SignType)signType loginHandler:(LoginHandler)logHandler;
@property (nonatomic, copy)LoginHandler loginHandler;
@end