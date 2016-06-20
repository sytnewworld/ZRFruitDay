//
//  ZRBaseViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRProductDetailViewController.h"
#import "ZRWebViewDetailViewController.h"

@implementation ZRBaseViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.childViewControllers.count == 1) {
        
        //  去掉返回按钮的内容
        UIBarButtonItem *backButtomItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(barBack)];
        self.navigationItem.backBarButtonItem = backButtomItem;
        self.navigationController.navigationBar.tintColor = COLOR_TITLE;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // 在下面两个ViewController中自定义NavigationBar
    if ([self.navigationController.childViewControllers.lastObject isKindOfClass:[ZRProductDetailViewController class]] || [self.navigationController.childViewControllers.lastObject isKindOfClass:[ZRWebViewDetailViewController class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    //  在其他ViewController中显示原有导航栏
    if (![self.navigationController.childViewControllers.lastObject isKindOfClass:[ZRProductDetailViewController class]] && ![self.navigationController.childViewControllers.lastObject isKindOfClass:[ZRWebViewDetailViewController class]]) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

#pragma mark - Private Methods
- (void)barBack {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
