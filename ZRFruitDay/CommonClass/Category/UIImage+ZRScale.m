//
//  UIImage+ZRScale.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/2.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  调整图片大小
//

#import "UIImage+ZRScale.h"

@implementation UIImage (ZRScale)

- (UIImage *)scaleToSize:(CGSize)size {

    //  创建一个bitmap的context
    //  并把它设置为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    //  绘制改变大小的图片
    [self drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
    //  从当前的context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    //  使当前的context出栈堆
    UIGraphicsEndImageContext();
    //  返回新的改变大小后的图片
    return scaledImage;
}

@end
