//
//  ZRTabBarController.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRCustomTabbarItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIImage *unselectedImage;

- (id)initWithTitle:(NSString *)title selectedImage:(UIImage *)selectedImage unselectedImage:(UIImage *)unselectedImage;

@end

@interface ZRTabBarController : UITabBarController

@property (nonatomic, strong) NSArray *tabbarItems;

@end
