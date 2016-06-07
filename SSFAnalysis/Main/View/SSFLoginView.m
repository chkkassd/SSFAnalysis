//
//  SSFLoginView.m
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/16.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "SSFLoginView.h"
#import "SSFGravityCollisionBehavior.h"
#import "SSFAnalysisManager.h"
#import "CZSShowSimpleAlert.h"

IB_DESIGNABLE
#define GapWidth 8
#define DefaultComponentHeight  30

@interface SSFLoginView()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *displayNameTextField;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic,assign) SignType signType;
@end

@implementation SSFLoginView

- (instancetype)initWithFrame:(CGRect)frame signType:(SignType)signType loginHandler:(LoginHandler)logHandler{
    self = [super initWithFrame:frame];
    if (self) {
        self.loginHandler = logHandler;
        self.signType = signType;
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
    
//    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(-10, -10, 20, 20)];
//    [cancelButton setImage:[UIImage imageNamed:@"close_loding"] forState:UIControlStateNormal];
//    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [_alertView addSubview:cancelButton];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(GapWidth, GapWidth, _alertView.frame.size.width - GapWidth*2, DefaultComponentHeight)];
    _nameTextField.placeholder = @"请输入邮箱";
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.backgroundColor = [UIColor colorWithWhite:230/255.0 alpha:1.0];
    [_alertView addSubview:_nameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(GapWidth, GapWidth*2 + _nameTextField.frame.size.height, _alertView.frame.size.width - GapWidth*2, DefaultComponentHeight)];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.backgroundColor = [UIColor colorWithWhite:230/255.0 alpha:1.0];
    [_alertView addSubview:_passwordTextField];
    
    if (self.signType == SSFLoginViewSignUp) {
        _displayNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(GapWidth, GapWidth + _passwordTextField.frame.origin.y + _passwordTextField.frame.size.height, _alertView.frame.size.width - GapWidth*2, DefaultComponentHeight)];
        _displayNameTextField.placeholder = @"请输入昵称";
        _displayNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _displayNameTextField.backgroundColor = [UIColor colorWithWhite:230/255.0 alpha:1.0];
        [_alertView addSubview:_displayNameTextField];

    }
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(GapWidth,GapWidth + (self.signType == SSFLoginViewSignUp ? (_displayNameTextField.frame.origin.y + _displayNameTextField.frame.size.height) : (_passwordTextField.frame.origin.y + _passwordTextField.frame.size.height)), _alertView.frame.size.width - GapWidth*2, DefaultComponentHeight)];
    loginButton.layer.borderWidth = 0.5f;
    loginButton.layer.borderColor = [UIColor colorWithWhite:220/255.0 alpha:1.0].CGColor;
    loginButton.layer.cornerRadius = 5.0;
    [loginButton setTitle:(self.signType == SSFLoginViewSignUp ? @"注册" :@"登录") forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithRed:255/255.0 green:67/255.0 blue:68/255.0 alpha:1.0] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:loginButton];
    
    _alertView.frame= CGRectMake(0,-(4*GapWidth + 3*DefaultComponentHeight),frame.size.width*2/3, (GapWidth + loginButton.frame.origin.y + loginButton.frame.size.height));
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 5.0;
    [self addSubview:_alertView];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/6 + GapWidth, frame.size.height/6 - DefaultComponentHeight- GapWidth/2, _alertView.frame.size.width - 2*GapWidth, DefaultComponentHeight)];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.textColor = [UIColor whiteColor];
    _infoLabel.hidden = YES;
    [self addSubview:_infoLabel];
    
    //spring animation
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
        _alertView.frame = CGRectMake(frame.size.width/6, frame.size.height/6, frame.size.width*2/3, (GapWidth + loginButton.frame.origin.y + loginButton.frame.size.height));
    } completion:^(BOOL finished) {
    }];
    [_nameTextField becomeFirstResponder];
    
    //gesture
    [self configureTapGesture];
    
}

- (void)configureTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancel)];
    [self addGestureRecognizer:tap];
}

- (void)tapCancel {
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.frame = CGRectMake(0,self.frame.size.height,self.frame.size.width*2/3, 4*GapWidth + 3*DefaultComponentHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self endEditing:YES];
        [self removeFromSuperview];
    }];
}

- (void)loginButtonPressed {
    if ([self checkEmailAndPassword]) {
        UIView *indicatorBgView = [self loadingIndicatorView];
        if (self.signType == SSFLoginViewSignIn) {
            [[SSFAnalysisManager sharedManager] userLoginAndSaveWithEmail:self.nameTextField.text password:self.passwordTextField.text completionHandler:^(NSString *description,BOOL success) {
                if (success) {
                    self.loginHandler();
                } else {
                    [indicatorBgView removeFromSuperview];
                    [self showAlertWithText:description];
                }
            }];
        }
        else if (self.signType == SSFLoginViewSignUp) {
            [[SSFAnalysisManager sharedManager] userSignUpAndSaveWithEmail:self.nameTextField.text displayName:self.displayNameTextField.text password:self.passwordTextField.text completionHaneldr:^(NSString *description, BOOL success) {
                if (success) {
                    [[SSFAnalysisManager sharedManager] userLoginAndSaveWithEmail:self.nameTextField.text password:self.passwordTextField.text completionHandler:^(NSString *description,BOOL success) {
                        if (success) {
                            self.loginHandler();
                        } else {
                            [indicatorBgView removeFromSuperview];
                            [self showAlertWithText:description];
                        }
                    }];
                } else {
                    [indicatorBgView removeFromSuperview];
                    [self showAlertWithText:description];
                }
            }];
        }
    }
}

- (UIView *)loadingIndicatorView {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color = [UIColor lightGrayColor];
    indicator.hidesWhenStopped = YES;
    [indicator startAnimating];
    UIView *indicatorBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, self.alertView.frame.size.height)];
    indicatorBgView.backgroundColor = [UIColor whiteColor];
    [indicatorBgView addSubview:indicator];
    indicator.center = indicatorBgView.center;
    [self.alertView addSubview:indicatorBgView];
    return indicatorBgView;
}

- (BOOL)checkEmailAndPassword {
    if (!self.nameTextField.text.length) {
        [self showAlertWithText:@"请输入用户名"];
        return NO;
    } else if (!self.passwordTextField.text.length) {
        [self showAlertWithText:@"请输入密码"];
        return NO;
    } else if (self.signType == SSFLoginViewSignUp) {
        if (!self.displayNameTextField.text.length) {
            [self showAlertWithText:@"请输入昵称"];
            return NO;
        } else return YES;
    } else return YES;
}

- (void)showAlertWithText:(NSString *)text {
    self.infoLabel.text = text;
    [UIView animateWithDuration:0.5 animations:^{
        self.infoLabel.alpha = 1;
    }completion:^(BOOL finished) {
        self.infoLabel.hidden = NO;
    }];

}
@end
