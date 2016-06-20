//
//  ZRUser.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/29.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRUser : NSObject

/// 单例模式下的用户
+ (ZRUser *)sharedInstance;
/// 清除登录内容
- (void)clear;

/// 用户是否登录
@property (nonatomic, assign) BOOL isLogin;

@end
