//
//  ZRPersonalGardenViewController.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  我的果园
//

#import "ZRBaseViewController.h"

/// 登录成功后回调
typedef void(^ZRLoginBackBlock)(void);

@interface ZRPersonalGardenViewController : ZRBaseViewController

@property (nonatomic, copy) ZRLoginBackBlock loginBackBlock;

@end
