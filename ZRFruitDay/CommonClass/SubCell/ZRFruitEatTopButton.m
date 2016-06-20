//
//  ZRFruitEatTopButton.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/2.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRFruitEatTopButton.h"
#import "CommonDefines.h"

@implementation ZRFruitEatTopButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    return CGRectMake(0.0, 0.0, 11.0 * 4, 11.0 * 3);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    CGFloat width = 40.0;
    CGFloat xOrigin = ((SCREEN_WIDTH - 1.0 * 2)/3 - width)/2;
    CGFloat yOrigin = 12.0;
    return CGRectMake(xOrigin, yOrigin, width, width);
}

@end
