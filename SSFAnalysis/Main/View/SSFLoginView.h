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
    SSFLoginViewSignIn,
    SSFLoginViewSignUp
};

@interface SSFLoginView : UIView
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame signType:(SignType)signType loginHandler:(LoginHandler)logHandler NS_DESIGNATED_INITIALIZER;
@property (nonatomic, copy)LoginHandler loginHandler;
@end