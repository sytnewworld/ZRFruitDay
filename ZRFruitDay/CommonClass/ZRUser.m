//
//  ZRUser.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/29.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRUser.h"

static ZRUser *_instance = nil;

@implementation ZRUser

/// 单例模式下的用户
+ (ZRUser *)sharedInstance {

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[ZRUser alloc] init];
            _instance.isLogin = NO;
        }
    });
    return _instance;
}

/// 清除登录内容
- (void)clear {

    _isLogin = NO;
}

@end
