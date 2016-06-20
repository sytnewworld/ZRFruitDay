//
//  ZRHistogram.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/2.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  直方图
//

#import "ZRHistogram.h"

#define HEIGHT_PERCENTAGE 0.8   //  百分之一对应的高度

@interface ZRHistogram ()

/// 百分比标题
@property (nonatomic, strong) UILabel *percentLabel;
/// 文字标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 矩形图
@property (nonatomic, strong) UIView *histogramView;

@end

@implementation ZRHistogram

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self buildView];
    }
    return self;
}

/// 动态设置三个子view的frame
- (void)layoutSubviews {
    
    [super layoutSubviews];
}

#pragma mark - 懒加载
/// 文字标题
- (UILabel *)titleLabel {

    if (!_titleLabel) {
        //  文字标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

/// 百分比标题
- (UILabel *)percentLabel {

    if (!_percentage) {
        //  百分比标题
        _percentLabel = [[UILabel alloc] init];
        _percentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _percentLabel;
}

/// 矩形图
- (UIView *)histogramView {

    if (!_histogramView) {
        //  矩形图
        _histogramView = [[UIView alloc] init];
    }
    return _histogramView;
}

#pragma mark - Private Methods
/// 初始化视图
- (void)buildView {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.percentLabel];
    [self addSubview:self.histogramView];
    _percentLabel.hidden = YES;
}

/// 文字标题的内容
- (void)setTextTitle:(NSString *)textTitle {

    _textTitle = textTitle;
    self.titleLabel.text = textTitle;
    //  计算文字标题的高度
//    CGSize size = [textTitle sizeWithFont:_titleLabel.font forWidth:self.frame.size.width lineBreakMode:NSLineBreakByCharWrapping];
    CGSize maxSize = CGSizeMake(self.window.bounds.size.width, 2000.0);
    CGSize size = [_textTitle boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:_titleLabel.font} context:nil].size;
    _titleLabel.frame = CGRectMake(0.0, self.frame.size.height - size.height, self.frame.size.width, size.height);
}

/// 百分比标题的内容
- (void)setPercentage:(NSInteger)percentage {

    _percentage = percentage;
    _percentLabel.hidden = YES;
    CGFloat yOrigin = 0.0;
    CGFloat height = 0.0;
    _histogramView.frame = CGRectMake((CGRectGetWidth(self.frame) - 20.0)/2, _titleLabel.frame.origin.y - 6.0, 20.0, 0);
    //  画图
    for (NSInteger i = 0; i < percentage; i++) {
        
        //  设置图标的frame
        yOrigin = _titleLabel.frame.origin.y - 6.0 - HEIGHT_PERCENTAGE * i;
        height = HEIGHT_PERCENTAGE * (i + 1);
        [UIView animateWithDuration:2.0f animations:^{
            CGRect frame = _histogramView.frame;
            frame.origin.y = yOrigin;
            frame.size.height = height;
            _histogramView.frame = frame;
        }completion:^(BOOL finished) {
            if (finished && i == percentage - 1) {
                _percentLabel.hidden = NO;
            }
        }];
    }
    //  百分比标题
    _percentLabel.text = [NSString stringWithFormat:@"%ld％",percentage];
//    CGSize size = [_percentLabel.text sizeWithFont:_percentLabel.font forWidth:self.frame.size.width lineBreakMode:NSLineBreakByCharWrapping];
    CGSize maxSize = CGSizeMake(self.window.bounds.size.width, 2000.0);
    CGSize size = [_percentLabel.text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:_percentLabel.font} context:nil].size;

    _percentLabel.frame = CGRectMake(0.0, _titleLabel.frame.origin.y - 6.0 - HEIGHT_PERCENTAGE * percentage - 11.0 - 11.0, self.frame.size.width, size.height);
}

#pragma mark - Public Methods
/// 文字标题字体和颜色
- (void)setTextTitleLabelWithTextColor:(UIColor *)color font:(UIFont *)font {
    
    _titleLabel.textColor = color;
    _titleLabel.font = font;
}

/// 百分比标题字体和颜色
- (void)setPercentTitleLabelWithTextColor:(UIColor *)color font:(UIFont *)font {
    
    _percentLabel.textColor = color;
    _percentLabel.font = font;
}

/// 矩形图的背景颜色
- (void)setHistogramViewBackgroundColor:(UIColor *)backgroundColor {

    _histogramView.backgroundColor = backgroundColor;
}
@end
