//
//  LoginView.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

// MARK: View
#import "LoginView.h"

// MARK: Tool
#import "InputValidator.h"
#import "LoginManager.h"
#import "MD5Encryptor.h"

// MARK: Category
#import "UIFont+Extension.h"

// MARK: 登录错误类型
typedef NS_ENUM(NSUInteger, LoginErrorType) {
    LoginErrorTypeUsernameIsEmpty = 0,              // 未输入用户名
    LoginErrorTypePasswordIsEmpty,                  // 未输入密码
    LoginErrorTypeUsernameNotExist,                 // 用户不存在
    LoginErrorTypeWrongPassword,                    // 密码错误
    LoginErrorTypeUsernameNotExistOrWrongPassword,  // 用户名或密码错误
    LoginErrorTypeNetworkError                      // 网络错误
};

static const CGFloat kMargin              = 25.0;
static const CGFloat kOffset              = 84.0;
static const CGFloat kCornerRadius        = 3.0;
static const CGFloat kInputViewHeight     = 88.0;
static const CGFloat kTextFieldTopPadding = 2.5;
static const CGFloat kTextFieldHeight     = kInputViewHeight * 0.5 - kTextFieldTopPadding * 2;
static const CGFloat kLoginButtonHeight   = 44.0;
static const CGFloat kPadding             = 10.0;

@interface LoginView ()
@property (strong, nonatomic) UIImage     *logo;
@property (strong, nonatomic) UIImage     *backgroundImage;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIView      *inputView;
@property (strong, nonatomic) UIView      *separatorLine;
@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton    *loginButton;
@property (strong, nonatomic) UILabel     *tipLabel;
@end

@implementation LoginView

#pragma mark - Setter   |   Getter

- (UIImage *)logo {
    if (!_logo) {
        _logo = [UIImage imageNamed:@"logo"];
    }
    
    return _logo;
}

- (UIImage *)backgroundImage {
    
    if (!_backgroundImage) {
        _backgroundImage = [UIImage imageNamed:@"login_background"];
    }
    
    return _backgroundImage;
}

- (UIImageView *)logoImageView {
    
    if (!_logoImageView) {
        _logoImageView = ({
            UIImageView *logoImageView = [[UIImageView alloc] init];
            logoImageView.image = self.logo;
            logoImageView;});
    }
    
    return _logoImageView;
}

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        _backgroundImageView = ({
            UIImageView *backgroundImageView = [[UIImageView alloc] init];
            backgroundImageView.image = self.backgroundImage;
            backgroundImageView.userInteractionEnabled = YES;
            [backgroundImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundAction)]];
            backgroundImageView;});
    }
    
    return _backgroundImageView;
}

- (UIView *)inputView {
    
    if (!_inputView) {
        _inputView = ({
            UIView *inputView = [[UIView alloc] init];
            inputView.backgroundColor = [UIColor whiteColor];
            inputView.layer.cornerRadius = kCornerRadius;
            inputView.layer.masksToBounds = YES;
            inputView;});
    }
    
    return _inputView;
}

- (UITextField *)usernameTextField {
    
    if (!_usernameTextField) {
        _usernameTextField = ({
            UITextField *usernameTextField = [[UITextField alloc] init];
            usernameTextField.placeholder = @"Username";
            usernameTextField;});
    }
    
    return _usernameTextField;
}

- (UITextField *)passwordTextField {
    
    if (!_passwordTextField) {
        _passwordTextField = ({
            UITextField *passwordTextField = [[UITextField alloc] init];
            passwordTextField.placeholder = @"Password";
            passwordTextField;});
    }
    
    return _passwordTextField;
}

- (UIView *)separatorLine {
    
    if (!_separatorLine) {
        _separatorLine = ({
            UIView *separatorLine = [[UIView alloc] init];
            separatorLine.backgroundColor = HEX_COLOR(0xDDDDDD);
            separatorLine;});
    }
    
    return _separatorLine;
}

- (UIButton *)loginButton {
    
    if (!_loginButton) {
        _loginButton = ({
            UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [loginButton setTitle:@"Log In" forState:UIControlStateNormal];
            [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [loginButton addTarget:self
                            action:@selector(loginAction)
                  forControlEvents:UIControlEventTouchUpInside];
            loginButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.57 blue:0.95 alpha:1.0];
            loginButton.titleLabel.font = [UIFont fontWithSize:16];
            loginButton.layer.cornerRadius = kCornerRadius;
            loginButton.layer.masksToBounds = YES;
            loginButton;});
    }
    
    return _loginButton;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        _tipLabel = ({
            UILabel *tipLabel = [[UILabel alloc] init];
            tipLabel.textAlignment = NSTextAlignmentCenter;
            tipLabel.textColor = [UIColor redColor];
            tipLabel.alpha = 0.0;
            tipLabel;});
    }
    
    return _tipLabel;
}

#pragma mark - Life cycle

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.frame = SCREEN_BOUNDS;
        [self addSubview:self.backgroundImageView];
        [self.backgroundImageView addSubview:self.logoImageView];
        [self.backgroundImageView addSubview:self.inputView];
        [self.backgroundImageView addSubview:self.loginButton];
        [self.backgroundImageView addSubview:self.tipLabel];
        [self.inputView addSubview:self.usernameTextField];
        [self.inputView addSubview:self.separatorLine];
        [self.inputView addSubview:self.passwordTextField];
        [self addConstraint];
    }
    return self;
}

- (void)addConstraint {
    
    __weak __typeof(self)weakSelf = self;
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(kOffset);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(weakSelf.logo.size);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.logoImageView.mas_bottom).offset(kPadding * 2);
        make.left.equalTo(weakSelf.mas_left).offset(kMargin);
        make.right.equalTo(weakSelf.mas_right).offset(-kMargin);
        make.height.mas_offset(kInputViewHeight);
    }];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.inputView.mas_top).offset(kTextFieldTopPadding);
        make.height.mas_equalTo(kTextFieldHeight);
        make.left.equalTo(weakSelf.inputView.mas_left).offset(kPadding);
        make.right.equalTo(weakSelf.inputView.mas_right).offset(-kPadding);
    }];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.usernameTextField.mas_bottom).offset(kTextFieldTopPadding - 0.5);
        make.left.and.right.equalTo(weakSelf.inputView);
        make.height.mas_equalTo(0.5);
    }];

    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.separatorLine.mas_bottom).offset(kTextFieldTopPadding);
        make.left.and.right.equalTo(weakSelf.usernameTextField);
        make.height.equalTo(weakSelf.usernameTextField.mas_height);
    }];

    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.inputView.mas_bottom).offset(kPadding);
        make.left.and.right.equalTo(weakSelf.inputView);
        make.height.mas_equalTo(kLoginButtonHeight);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.loginButton);
    }];
}

#pragma mark - Action

- (void)loginAction {
    
    if ([InputValidator isEmpty:self.usernameTextField.text]) {
        
        [self showLoginErrorAnimationWithErrorType:LoginErrorTypeUsernameIsEmpty];
    } else if ([InputValidator isEmpty:self.passwordTextField.text]) {
        
        [self showLoginErrorAnimationWithErrorType:LoginErrorTypePasswordIsEmpty];
    } else {
        
        [LoginManager loginWithUsername:self.usernameTextField.text password:[MD5Encryptor MD5EncryptWithString:self.passwordTextField.text]];
    }
}

- (void)tapBackgroundAction {
    
    [self.inputView.subviews makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

#pragma mark - Animation

- (void)showLoginErrorAnimationWithErrorType:(LoginErrorType)errorType {
    
    self.tipLabel.text = [self errorWithErrorType:errorType];
    __block CGPoint center = self.loginButton.center;
    center.y += 44;
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.loginButton.center = center;
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            center.y -= 44;
            [UIView animateWithDuration:0.4 delay:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.loginButton.center = center;
                self.tipLabel.alpha = 0.0;
            } completion:nil];
        }
    }];
    
    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.tipLabel.alpha = 1.0;
    } completion:nil];
}

#pragma mark - Helper

- (NSString *)errorWithErrorType:(LoginErrorType)errorType {
    
    NSString *error = @"";
    if (errorType == LoginErrorTypeUsernameIsEmpty) {
        
        error = @"请输入帐号";
    } else if (errorType == LoginErrorTypePasswordIsEmpty) {
        
        error = @"请输入密码";
    } else if (errorType == LoginErrorTypeUsernameNotExistOrWrongPassword) {
        
        error = @"账号或密码错误";
    } else if (errorType == LoginErrorTypeNetworkError) {
        
        error = @"网络异常";
    }
    
    return error;
}
@end
