//
//  AppDelegate.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "AppDelegate.h"
#import "ZRBaseNavigationController.h"
#import "ZRHomeViewController.h"
#import "ZRPersonalGardenViewController.h"
#import "ZRFruitEatViewController.h"
#import "ZRShoppingCartViewController.h"
#import "ZRClassifyViewController.h"
#import "ZRTabBarController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) ZRTabBarController *tabbarController;

@end

@implementation AppDelegate

#pragma mark - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self buildTabBarController];
    self.window.rootViewController = self.tabbarController;
    
    [self.window makeKeyAndVisible];
    
//    [UMSocialData setAppKey:@"56c592f3e0f55abdd9001b28"];
    return YES;
}

///  初始化TabBarController
- (void)buildTabBarController {

    self.tabbarController = [[ZRTabBarController alloc] init];
    
    ZRHomeViewController *homeViewController = [[ZRHomeViewController alloc] init];
    ZRBaseNavigationController *homeNavigationController = [[ZRBaseNavigationController alloc] initWithRootViewController:homeViewController];
    
    ZRClassifyViewController *classifyViewController = [[ZRClassifyViewController alloc] init];
    ZRBaseNavigationController *classifyNavigationController = [[ZRBaseNavigationController alloc] initWithRootViewController:classifyViewController];
    
    ZRShoppingCartViewController *shoppingCartViewController = [[ZRShoppingCartViewController alloc] init];
    ZRBaseNavigationController *shoppingCartNavigationController = [[ZRBaseNavigationController alloc] initWithRootViewController:shoppingCartViewController];
    
    ZRPersonalGardenViewController *personalGardenViewController = [[ZRPersonalGardenViewController alloc] init];
    ZRBaseNavigationController *personalGardenNavigationController = [[ZRBaseNavigationController alloc] initWithRootViewController:personalGardenViewController];
    
    ZRFruitEatViewController *fruitEatViewController = [[ZRFruitEatViewController alloc] init];
    ZRBaseNavigationController *fruitEatNavigationController = [[ZRBaseNavigationController alloc] initWithRootViewController:fruitEatViewController];
    
    NSArray *rootViewControllers = [NSArray arrayWithObjects:homeNavigationController,classifyNavigationController,personalGardenNavigationController,shoppingCartNavigationController,fruitEatNavigationController, nil];
    
    ZRCustomTabbarItem *homeItem = [[ZRCustomTabbarItem alloc] initWithTitle:@"首页" selectedImage:[UIImage imageNamed:@"首页"] unselectedImage:[UIImage imageNamed:@"首页_高亮"]];
    ZRCustomTabbarItem *classifyItem = [[ZRCustomTabbarItem alloc] initWithTitle:@"品类" selectedImage:[UIImage imageNamed:@"品类"] unselectedImage:[UIImage imageNamed:@"品类_高亮"]];
    ZRCustomTabbarItem *userItem = [[ZRCustomTabbarItem alloc] initWithTitle:@"我的果园" selectedImage:[UIImage imageNamed:@"我的果园"] unselectedImage:[UIImage imageNamed:@"我的果园_高亮"]];
    ZRCustomTabbarItem *cartItem = [[ZRCustomTabbarItem alloc] initWithTitle:@"购物车" selectedImage:[UIImage imageNamed:@"购物车"] unselectedImage:[UIImage imageNamed:@"购物车_高亮"]];
    ZRCustomTabbarItem *fruitItem = [[ZRCustomTabbarItem alloc] initWithTitle:@"果食" selectedImage:[UIImage imageNamed:@"果食"] unselectedImage:[UIImage imageNamed:@"果食_高亮"]];
    self.tabbarController.delegate = self;
    self.tabbarController.tabBar.barTintColor = [UIColor zr_colorWithRed:247 green:247 blue:248 alpha:1.0f];
    self.tabbarController.tabbarItems = [NSArray arrayWithObjects:homeItem,classifyItem,userItem,cartItem,fruitItem, nil];
    self.tabbarController.viewControllers = rootViewControllers;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UITabbarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    //  获取当前tabBarController选中的位置
    NSArray *array = tabBarController.viewControllers;
    NSInteger index = [array indexOfObject:viewController];
    
    //  获取当前tabBarItem的ImageView
    UIButton *button = [tabBarController.tabBar.subviews objectAtIndex:index + 1];
    UIImageView *imageView = [button.subviews objectAtIndex:0];
    
    if (index == 0) {
        //  旋转效果动画
        CATransform3D transform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
        imageView.transform = CATransform3DGetAffineTransform(transform);
        [UIView animateWithDuration:.5f animations:^{
            imageView.transform = CGAffineTransformIdentity;
        }];
    }else if (index == 1) {
    
    }else if (index == 2) {
        //  弹簧效果动画
        //  缩放
        CGAffineTransform transformScale = CGAffineTransformMakeScale(0.3, 0.8);
        //  移动
        CGAffineTransform transformTranslate = CGAffineTransformMakeTranslation(0.0, -70.0);
        imageView.transform = CGAffineTransformConcat(transformScale, transformTranslate);
        imageView.alpha = 0.0;
        [UIView animateWithDuration:.5f delay:0.2f usingSpringWithDamping:.5f initialSpringVelocity:.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            imageView.alpha = 1.0;
            //  清空  transform
            imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }else if (index == 3) {
    
    }else {
        CGAffineTransform transformScale = CGAffineTransformMakeRotation(M_PI);
        CGRect frame = CGRectApplyAffineTransform(imageView.frame, transformScale);

        imageView.alpha = 0.0;
        [UIView animateWithDuration:.5f delay:0.2f usingSpringWithDamping:.5f initialSpringVelocity:.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            imageView.alpha = 1.0;
            imageView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }
    return YES;
}

@end
