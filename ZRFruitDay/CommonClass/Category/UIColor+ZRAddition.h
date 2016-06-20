//
//  UIColor+ZRAddition.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/21.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZRAddition)

+ (UIColor *)zr_colorFromHex:(NSInteger)hex;
+ (UIColor *)zr_colorFromHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor *)zr_colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (UIColor *)zr_colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
/**
 red:0-255
 green:0-255
 blue:0-255
 alpha:0-100
 */

@end
