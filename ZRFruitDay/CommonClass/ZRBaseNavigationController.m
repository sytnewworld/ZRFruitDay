//
//  ZRBaseNavigationController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRBaseNavigationController.h"
#import "ZRProductDetailViewController.h"
#import "ZRWebViewDetailViewController.h"
#import "CommonDefines.h"

@implementation ZRBaseNavigationController

- (void)viewDidLoad {

    [super viewDidLoad];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_TITLE,NSForegroundColorAttributeName, nil]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
