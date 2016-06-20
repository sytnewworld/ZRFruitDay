//
//  UIColor+ZRAddition.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/21.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "UIColor+ZRAddition.h"

@implementation UIColor (ZRAddition)

+ (UIColor *)zr_colorFromHex:(NSInteger)hex {

    return [self zr_colorFromHex:hex alpha:1.0f];
}

+ (UIColor *)zr_colorFromHex:(NSInteger)hex alpha:(CGFloat)alpha {

    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)zr_colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {

    return [self zr_colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)zr_colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {

    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

@end
