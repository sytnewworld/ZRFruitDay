//
//  ZRRegisterViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/17.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  注册、忘记密码页面
//

#import "ZRRegisterViewController.h"

@interface ZRRegisterViewController ()<ZRCommonViewDelegate>

/// 手机号
@property (nonatomic, strong) UITextField *phoneNumberTextField;

@end

@implementation ZRRegisterViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {

    [super viewDidLoad];
    [self customNavigationBar];
    [self buildRegisterView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [_phoneNumberTextField becomeFirstResponder];
}

#pragma mark - Build View
/// 自定义导航栏
- (void)customNavigationBar {

    NSString *title = nil;
    if (self.viewControllerType == ViewControllerTypeRegister) {
        title = @"注册";
    }else if (self.viewControllerType == ViewControllerTypeForgetPassword) {
        title = @"忘记密码";
    }
    UIView *customNavigationBar = [ZRCommonView customNavigationBarWithDelegate:self backIconImage:[UIImage imageNamed:@"navibar_back_icon"] title:title];
    [self.view addSubview:customNavigationBar];
}

/// 注册界面
- (void)buildRegisterView {

    //  点击空白区域，隐藏键盘
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0.0, PHONE_NAVIGATIONBAR_HEIGHT + PHONE_STATUSBAR_HEIGHT, SCREEN_WIDTH, VIEW_HIDETABBAR_HEIGHT)];
    [control addTarget:self action:@selector(hidesKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:control];
    
    CGFloat width = 220.0;
    CGFloat height = 35.0;
    //  手机号文本框
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - width)/2, 155.0, width, height)];
    _phoneNumberTextField.placeholder = @"手机号";
    _phoneNumberTextField.tintColor = COLOR_LOGIN_SPECIAL;
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 33.0, 32.0)];
    [leftView setImage:[UIImage imageNamed:@"phone"]];
    leftView.contentMode = UIViewContentModeLeft;
    _phoneNumberTextField.leftView = leftView;
    _phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_phoneNumberTextField];
    
    //  获取验证码按钮
    UIButton *getCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(_phoneNumberTextField.frame.origin.x, CGRectGetMaxY(_phoneNumberTextField.frame) + 14.0, width, height)];
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeButton setTitleColor:COLOR_SPECIAL forState:UIControlStateNormal];
    getCodeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    getCodeButton.layer.borderColor = COLOR_SPECIAL.CGColor;
    getCodeButton.layer.borderWidth = 1.0;
    getCodeButton.layer.cornerRadius = 35.0/2;
    [getCodeButton addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCodeButton];
    
    //  分割线
    UIView *lineView = [ZRCommonView generateSeperatorLineWithOriginX:_phoneNumberTextField.frame.origin.x originY:CGRectGetMaxY(_phoneNumberTextField.frame) width:width thickness:.5 lineColor:COLOR_LOGIN_SPECIAL direction:0];
    [self.view addSubview:lineView];
}

#pragma mark - Actions
/// 获取验证码
- (void)getCode:(UIButton *)button {

    NSLog(@"获取验证码");
    if ([_phoneNumberTextField.text isEqualToString:@""]) {
        [[ZRCommonView customAlertViewWithMessage:@"请输入手机号"] show];
    }
}

/// 隐藏键盘
- (void)hidesKeyboard {

    [_phoneNumberTextField resignFirstResponder];
}
@end
