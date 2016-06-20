//
//  ZRRegisterViewController.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/17.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  注册、忘记密码页面
//

#import "ZRBaseViewController.h"

/// 两种界面类型:注册界面、忘记密码界面
typedef NS_ENUM(NSInteger, ViewControllerType) {
    
    ViewControllerTypeRegister = 0,
    ViewControllerTypeForgetPassword
};

@interface ZRRegisterViewController : ZRBaseViewController

/// 界面类型
@property (nonatomic, assign) ViewControllerType viewControllerType;

@end
