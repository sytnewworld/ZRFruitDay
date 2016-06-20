//
//  ZRLoginViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/17.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  登陆页面
//

#import "ZRLoginViewController.h"
#import "ZRRegisterViewController.h"

@interface ZRLoginViewController ()<ZRCommonViewDelegate,UITextFieldDelegate>

/// 用户名
@property (nonatomic, strong) UITextField *userNameTextField;
/// 密码
@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation ZRLoginViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {

    [super viewDidLoad];
    [self customNavigationBar];
    [self buildLoginView];
}

#pragma mark - Build View
/// 自定义导航栏
- (void)customNavigationBar {

    UIView *customNavigtionBar = [ZRCommonView customNavigationBarWithDelegate:self backIconImage:[UIImage imageNamed:@"navibar_back_icon"] title:@"登录"];
    [self.view addSubview:customNavigtionBar];
}

/// 登录界面
- (void)buildLoginView {

    //  取消键盘,放在最底层
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0.0, 64.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [control addTarget:self action:@selector(hidesKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
    
    CGFloat width = 220.0;
    CGFloat height = 35.0;
    
    //   手机号、邮箱
    self.userNameTextField.frame = CGRectMake((SCREEN_WIDTH - width)/2, 194.0 - height, width, height);
    _userNameTextField.placeholder = @"手机/邮箱";
    [self.view addSubview:_userNameTextField];
    
    //  上分割线
    UIView *topLineView = [ZRCommonView generateSeperatorLineWithOriginX:_userNameTextField.frame.origin.x originY:CGRectGetMaxY(_userNameTextField.frame) width:width thickness:.5 lineColor:COLOR_LOGIN_SPECIAL direction:0];
    [self.view addSubview:topLineView];
    
    //  密码
    self.passwordTextField.frame = CGRectMake(_userNameTextField.frame.origin.x, CGRectGetMaxY(_userNameTextField.frame) + 46.0 - height, width, height);
    _passwordTextField.placeholder = @"密码";
    [self.view addSubview:_passwordTextField];
    
    //  下分割线
    UIView *bottomLineView = [ZRCommonView generateSeperatorLineWithOriginX:_userNameTextField.frame.origin.x originY:CGRectGetMaxY(_passwordTextField.frame) width:width thickness:.5 lineColor: COLOR_LOGIN_SPECIAL direction:0];
    [self.view addSubview:bottomLineView];
    
    [self buildButton];
    [self buildQuickLoginView];
}

/// 登录、注册、忘记密码按钮
- (void)buildButton {

    CGFloat width = 220.0;
    CGFloat height = 35.0;
    //  登录按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(_userNameTextField.frame.origin.x, CGRectGetMaxY(_passwordTextField.frame) + 21.0, width, height)];
    loginButton.backgroundColor = COLOR_SPECIAL;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    loginButton.layer.cornerRadius = 35.0/2;
    [loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    //  注册按钮
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(_userNameTextField.frame.origin.x, CGRectGetMaxY(loginButton.frame) + 17.0, width, height)];
    [registerButton setTitle:@"立即注册 享新客专享折扣" forState:UIControlStateNormal];
    [registerButton setTitleColor:COLOR_SPECIAL forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
    registerButton.layer.cornerRadius = 35.0/2;
    registerButton.layer.borderColor = COLOR_SPECIAL.CGColor;
    registerButton.layer.borderWidth = 1.0;
    [registerButton addTarget:self action:@selector(clickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    //  忘记密码
    UIButton *forgetPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH - width)/2 - 12.0 * 5, CGRectGetMaxY(registerButton.frame) + 16.0, 12.0 * 5, 12.0)];
    [forgetPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:COLOR_LOGIN_SPECIAL forState:UIControlStateNormal];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [forgetPasswordButton addTarget:self action:@selector(clickForgetPasswordButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordButton];
}

/// 快捷登录视图
- (void)buildQuickLoginView {

    //  快捷登录标签显示
    UILabel *quickLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake(56.0, SCREEN_HEIGHT - 12.0 - 29.0, 12.0 * 4, 12.0)];
    quickLoginLabel.font = [UIFont systemFontOfSize:12.0];
    quickLoginLabel.textColor = COLOR_LOGIN_SPECIAL;
    quickLoginLabel.text = @"快捷登录";
    [self.view addSubview:quickLoginLabel];
}

#pragma mark - Private Methods
/// 懒加载登录、注册输入框
- (UITextField *)userNameTextField {

    if (!_userNameTextField) {
        
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.font = [UIFont systemFontOfSize:15.0];
        _userNameTextField.tintColor = COLOR_LOGIN_SPECIAL;
        _userNameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _userNameTextField.returnKeyType = UIReturnKeyDefault;
        _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTextField.delegate = self;
        
        //  左视图
        UIImageView *userNameLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 33.0, 16.0)];
        [userNameLeftView setImage:[UIImage imageNamed:@"userIcon"]];
        userNameLeftView.contentMode = UIViewContentModeLeft;
        _userNameTextField.leftView = userNameLeftView;
        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _userNameTextField;
}

- (UITextField *)passwordTextField {

    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.font = [UIFont systemFontOfSize:15.0];
        _passwordTextField.tintColor = COLOR_LOGIN_SPECIAL;
        _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.textAlignment = NSTextAlignmentLeft;
        _passwordTextField.delegate = self;
        
        //  做视图
        UIImageView *passwordLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 33.0, 16.0)];
        [passwordLeftView setImage:[UIImage imageNamed:@"passwordIcon"]];
        passwordLeftView.contentMode = UIViewContentModeLeft;
        _passwordTextField.leftView = passwordLeftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _passwordTextField;
}

/// 跳转至 注册、忘记密码页面
- (void)showViewControllerWithViewControllerType:(ViewControllerType)viewControllerType {

    ZRRegisterViewController *forgetPasswordViewController = [[ZRRegisterViewController alloc] init];
    forgetPasswordViewController.viewControllerType = viewControllerType;
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}

#pragma mark - Actions
/// 响应登录按钮
- (void)clickLoginButton:(UIButton *)button {

    NSLog(@"登录");
    //  判断用户名和密码是否均已输入
    //  手机号未输入,提示:请输入手机号
    if ([_userNameTextField.text isEqualToString:@""]) {
        [[ZRCommonView customAlertViewWithMessage:@"请输入手机号"] show];
    }else if ([_passwordTextField.text isEqualToString:@""]) {
        [[ZRCommonView customAlertViewWithMessage:@"请输入密码"] show];
    }
}

/// 响应注册按钮
- (void)clickRegisterButton:(UIButton *)button {

    NSLog(@"注册");
    [self showViewControllerWithViewControllerType:ViewControllerTypeRegister];
}

/// 响应忘记密码按钮
- (void)clickForgetPasswordButton:(UIButton *)button {

    NSLog(@"忘记密码");
    [self showViewControllerWithViewControllerType:ViewControllerTypeForgetPassword];
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56c592f3e0f55abdd9001b28" shareText:@"分享页面" shareImage:[UIImage imageNamed:@""] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToTencent, UMShareToAlipaySession, nil] delegate:nil];
}

/// 取消键盘
- (void)hidesKeyboard {

    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self hidesKeyboard];
    return YES;
}
@end
