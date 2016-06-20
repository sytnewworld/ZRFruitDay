//
//  CommonDefines.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/18.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "UIColor+ZRAddition.h"

#ifndef CommonDefines_h
#define CommonDefines_h

#define IOS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]

// 常用尺寸
/// iPhone  屏幕宽度
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
/// iPhone  屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
/// iPhone  默认导航条高度
#define PHONE_NAVIGATIONBAR_HEIGHT  44.0
/// iPhone  statusBar高度
#define PHONE_STATUSBAR_HEIGHT      20.0
/// iPhone  默认TabBar高度
#define PHONE_TABBAR_HEIGHT         49.0
/// iPhone  除去导航栏和statusBar高度,TabBar之后的View高度
#define VIEW_HEIGHT     (SCREEN_HEIGHT - PHONE_NAVIGATIONBAR_HEIGHT - PHONE_STATUSBAR_HEIGHT - PHONE_TABBAR_HEIGHT)
/// 隐藏TabBar的UIViewController中View的高度
#define VIEW_HIDETABBAR_HEIGHT      (SCREEN_HEIGHT - PHONE_NAVIGATIONBAR_HEIGHT - PHONE_STATUSBAR_HEIGHT)

/// 背景颜色
#define COLOR_BACKGROUND            [UIColor zr_colorFromHex:0xf6f6f6]
/// 分割线颜色
#define COLOR_SEPERATOR_LINE        [UIColor zr_colorFromHex:0xc8c8c8]
/// 导航栏标题颜色
#define COLOR_TITLE                 [UIColor zr_colorFromHex:0x3c8c1e]
/// 标题高亮
#define COLOR_HIGHLIGHT_TITLE       [UIColor zr_colorFromHex:0x68a55e]
/// 标题灰色
#define COLOR_GRAY_TITLE            [UIColor zr_colorFromHex:0xaaaaaa]
/// 标题暗灰
#define COLOR_HALF_GRAY_TITLE       [UIColor zr_colorFromHex:0x555555]
/// 标题亮灰色
#define COLOR_HIGHLIGHT_GRAY_TITLE  [UIColor zr_colorFromHex:0x696969]
/// 特殊颜色 —————— 价格橙色
#define COLOR_SPECIAL               [UIColor zr_colorFromHex:0xff9933]
/// 暗棕色 登录页面特殊位置
#define COLOR_LOGIN_SPECIAL         [UIColor zr_colorFromHex:0x887754]
/// 一级标题
#define COLOR_TITLE_BLACK           [UIColor zr_colorFromHex:0x2b2b2b]

#endif /* CommonDefines_h */
