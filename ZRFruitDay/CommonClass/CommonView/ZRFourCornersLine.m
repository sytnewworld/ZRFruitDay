//
//  ZRFourCornersLine.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/8.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRFourCornersLine.h"

@interface ZRFourCornersLine () {
    
    MyLayerDelegate *_layerDelegate;
}

@end

@implementation MyLayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    NSLog(@"%s",__func__);
    UIGraphicsPushContext(ctx);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(150.0, 130.0, 100.0, 100.0)];
    [[UIColor blueColor] setFill];
    [path fill];
    UIGraphicsPopContext();
}

@end

@implementation ZRFourCornersLine

+ (ZRFourCornersLine *)drawFourCornersViewWithFrame:(CGRect)frame {

    ZRFourCornersLine *fourCornersLine = [[ZRFourCornersLine alloc] initWithFrame:frame];
    fourCornersLine.backgroundColor = [UIColor whiteColor];
    return fourCornersLine;
}

//- (void)drawRect:(CGRect)rect {
//    
//    NSLog(@"%s",__func__);
////    //  获取当前画布
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    //  设置线条类型
////    CGContextSetLineCap(context, kCGLineCapSquare);
////    //  线宽
////    CGContextSetLineWidth(context, 2.0);
////    //  画笔颜色
////    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
////    //  开始一个路径
////    CGContextBeginPath(context);
////    //  起点
////    CGContextMoveToPoint(context, 0.0, 0.0);
////    //  
//    /// 使用UIKit在Cocoa为我们提供的当前上下文中完成绘图任务
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10.0, 20.0, 50.0, 50.0)];
//    [[UIColor blueColor] setFill];
//    [path fill];
//    
//    /// 使用Core Graphics实现绘制蓝色圆
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(context, CGRectMake(30.0, 80.0, 50.0, 50.0));
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillPath(context);
//}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();

//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(context, 1.0);
    
    //  设置点
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 20.0, 20.0);
    CGContextAddLineToPoint(context, 20.0, 100.0);
    CGContextAddLineToPoint(context, 150.0, 100.0);
    
    CGContextClosePath(context);
    
    //  设置上下文属性
//    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    [[UIColor greenColor] setFill];
//    [[UIColor blueColor] set];
    
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
