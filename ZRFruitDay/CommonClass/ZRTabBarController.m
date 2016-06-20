//
//  ZRTabBarController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRTabBarController.h"
#import "CommonDefines.h"

@implementation ZRCustomTabbarItem

- (id)initWithTitle:(NSString *)title selectedImage:(UIImage *)selectedImage unselectedImage:(UIImage *)unselectedImage {

    if (self = [super init]) {
        self.title = title;
        self.selectedImage = selectedImage;
        self.unselectedImage = unselectedImage;
    }
    return self;
}

@end

@implementation ZRTabBarController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.tabBar.translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *selectedColor = [UIColor zr_colorWithRed:63 green:139 blue:39];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       selectedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {

    if (viewControllers.count != self.tabbarItems.count || viewControllers.count == 0) {
        NSAssert(NO, @"%s",__FUNCTION__);
    }
    
    NSInteger k = 0;
    for (UIViewController *viewController in viewControllers) {
        UITabBarItem *tabbarItem = [self buildTabbarItemWithCustomTabBarItem:self.tabbarItems[k]];
        viewController.tabBarItem = tabbarItem;
        k++;
    }
    [super setViewControllers:viewControllers];
}

- (UITabBarItem *)buildTabbarItemWithCustomTabBarItem:(ZRCustomTabbarItem *)customTabBarItem {

    UITabBarItem *tabBarItem;
    if (IOS_VERSION >= 7.0) {
        tabBarItem = [[UITabBarItem alloc] initWithTitle:customTabBarItem.title image:[customTabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[customTabBarItem.unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }else {
        tabBarItem = [[UITabBarItem alloc] initWithTitle:customTabBarItem.title image:nil tag:0];
        tabBarItem = [[UITabBarItem alloc] initWithTitle:customTabBarItem.title image:customTabBarItem.unselectedImage selectedImage:customTabBarItem.selectedImage];
    }
    return tabBarItem;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

    NSLog(@"%ld",[tabBar.items indexOfObject:item]);
}
@end
