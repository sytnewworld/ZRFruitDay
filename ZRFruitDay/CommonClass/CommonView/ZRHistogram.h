//
//  ZRHistogram.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/2.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  直方图
//

#import <UIKit/UIKit.h>

@interface ZRHistogram : UIView

/// 百分比
@property (nonatomic, assign) NSInteger percentage;
/// 标题
@property (nonatomic, strong) NSString *textTitle;

/// 文字标题字体和颜色
- (void)setTextTitleLabelWithTextColor:(UIColor *)color font:(UIFont *)font;
/// 百分比标题字体和颜色
- (void)setPercentTitleLabelWithTextColor:(UIColor *)color font:(UIFont *)font;
/// 矩形图的背景颜色
- (void)setHistogramViewBackgroundColor:(UIColor *)backgroundColor;

@end
