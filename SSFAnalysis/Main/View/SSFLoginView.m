//
//  SSFLoginView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/16.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFLoginView.h"

IB_DESIGNABLE
#define GapWidth 8
#define DefaultComponentHeight  25

@interface SSFLoginView()
@property (nonatomic, strong) UIView *alertView;
@end

@implementation SSFLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViewWithFrame:frame];
    }
    return self;
}

- (void)configureViewWithFrame:(CGRect)frame {
    //construct
    self.backgroundColor = [UIColor clearColor];
    UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.5;
    [self addSubview:backgroundView];
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/6, frame.size.height/6, frame.size.width*2/3, 0)];
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.layer.cornerRadius = 5.0;
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(-8, -8, 16, 16)];
    [cancelButton setImage:[UIImage imageNamed:@"close_loding"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:cancelButton];
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(GapWidth, GapWidth, _alertView.frame.size.width - GapWidth*2, DefaultComponentHeight)];
    nameTextField.placeholder = @"请输入账号";
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.backgroundColor = [UIColor colorWithWhite:230/255.0 alpha:1.0];
    [_alertView addSubview:nameTextField];
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(GapWidth, GapWidth*2 + nameTextField.frame.size.height, _alertView.frame.size.width - GapWidth*2, DefaultComponentHeight)];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.backgroundColor = [UIColor colorWithWhite:230/255.0 alpha:1.0];
    [_alertView addSubview:passwordTextField];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(GapWidth,GapWidth*3 + nameTextField.frame.size.height + passwordTextField.frame.size.height, _alertView.frame.size.width - GapWidth*2, DefaultComponentHeight)];
    loginButton.layer.borderWidth = 0.5f;
    loginButton.layer.borderColor = [UIColor colorWithWhite:220/255.0 alpha:1.0].CGColor;
    loginButton.layer.cornerRadius = 5.0;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithRed:255/255.0 green:67/255.0 blue:68/255.0 alpha:1.0] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:loginButton];
    
    _alertView.frame= CGRectMake(0,-(4*GapWidth + 3*DefaultComponentHeight),frame.size.width*2/3, 4*GapWidth + 3*DefaultComponentHeight);
//    _alertView.frame = CGRectMake(frame.size.width/6, frame.size.height/6, frame.size.width*2/3, 4*GapWidth + 3*DefaultComponentHeight);
    [self addSubview:self.alertView];
    
    //animation
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionNone animations:^{
        _alertView.frame = CGRectMake(frame.size.width/6, frame.size.height/6, frame.size.width*2/3, 4*GapWidth + 3*DefaultComponentHeight);
    } completion:^(BOOL finished) {
        [nameTextField becomeFirstResponder];
    }];
    
}

- (void)cancelButtonPressed {
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionNone animations:^{
        self.alertView.frame = CGRectMake(0,-(4*GapWidth + 3*DefaultComponentHeight),self.frame.size.width*2/3, 4*GapWidth + 3*DefaultComponentHeight);
    } completion:^(BOOL finished) {
        [self endEditing:YES];
        
    }];
}

- (void)loginButtonPressed {
    
}

@end
