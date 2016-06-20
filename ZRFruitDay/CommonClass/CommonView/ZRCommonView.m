//
//  ZRCommonView.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  公共的视图
//

#import "ZRCommonView.h"
#import "CommonDefines.h"

@implementation ZRCommonView

/// 粗细为0.5的分割线
+ (UIView *)generateSeperatorLineWithOriginX:(CGFloat)xPoint originY:(CGFloat)yPoint width:(CGFloat)width direction:(NSInteger)direction {
    
    return [self generateSeperatorLineWithOriginX:xPoint originY:yPoint width:width thickness:.5 lineColor:COLOR_SEPERATOR_LINE direction:direction];
}

/**
 *  自定义不同粗细和颜色的分割线
 *
 *  @param xPoint    起始点的X坐标
 *  @param yPoint    起始点的Y坐标
 *  @param width     长度
 *  @param thickness 粗细程度
 *  @param lineColor 线条的颜色
 *  @param direction 方向:垂直、水平两种
 *
 *  @return 绘制好的分割线
 */
+ (UIView *)generateSeperatorLineWithOriginX:(CGFloat)xPoint originY:(CGFloat)yPoint width:(CGFloat)width thickness:(CGFloat)thickness lineColor:(UIColor *)lineColor direction:(NSInteger)direction; {
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineColor;
    if (direction == 0) {
        //  水平方向
        lineView.frame = CGRectMake(xPoint, yPoint, width, thickness);
    }else if (direction == 1) {
        //  垂直方向
        lineView.frame = CGRectMake(xPoint, yPoint, thickness, width);
    }
    return lineView;
}

/// 只有一个返回图标的导航栏
+ (UIView *)customNavigationBarWithDelegate:(id<ZRCommonViewDelegate>)delegate {

    return [self customNavigationBarWithDelegate:delegate backIconImage:[UIImage imageNamed:@"round_left_fill"] title:nil];
}

/// 自定义NavigationBar:返回图标、标题
+ (UIView *)customNavigationBarWithDelegate:(id<ZRCommonViewDelegate>)delegate backIconImage:(UIImage *)image title:(NSString *)title {

    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, SCREEN_WIDTH, 44.0)];
//    navigationBarView.backgroundColor = [UIColor clearColor];
    
    //  返回按钮
    UIButton *leftBackButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 0.0, 41.0, 41.0)];
    [leftBackButton setImage:image forState:UIControlStateNormal];
    if (delegate != nil && [delegate respondsToSelector:@selector(barBack)]) {
        [leftBackButton addTarget:delegate action:@selector(barBack) forControlEvents:UIControlEventTouchUpInside];
    }
    [navigationBarView addSubview:leftBackButton];
    
    //  标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 105.0)/2, 0.0, 105.0, 44.0)];
    titleLabel.textColor = COLOR_HIGHLIGHT_TITLE;
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navigationBarView addSubview:titleLabel];
    
    return navigationBarView;
}

/// 星级图标
+ (UIView *)customStarIconViewWithOrigin:(CGPoint)iconOrigin IconWidth:(CGFloat)iconWidth iconSpace:(CGFloat)space level:(NSInteger)level {

    CGFloat widthForView = iconWidth * level + space * (level - 1);
    UIView *starIconView = [[UIView alloc] initWithFrame:CGRectMake(iconOrigin.x, iconOrigin.y, widthForView, iconWidth)];
    for (NSInteger i = 0; i < level; i++) {
        UIImageView *imageView = nil;
        if (i == 0) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, iconWidth, iconWidth)];
        }else {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake((space + iconWidth) * i, 0.0, iconWidth, iconWidth)];
        }
        [imageView setImage:[UIImage imageNamed:@"star_rate"]];
        [starIconView addSubview:imageView];
    }
    return starIconView;
}

/// 画直方图
+ (UIView *)drawHistogramWithFrame:(CGRect)frame percentage:(CGFloat)percentage {


    UIView *histogramView = [[UIView alloc] initWithFrame:frame];
    histogramView.backgroundColor = [UIColor whiteColor];
    //  每个百分比对应的高度1.5
    CGFloat heightForPercent = 1.5;
    CGFloat height = percentage * heightForPercent;
    
    [UIView animateWithDuration:.5f animations:^{
        histogramView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    }];
    return histogramView;
}

/// 自定义弹出窗口
+ (UIAlertView *)customAlertViewWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    return alertView;
}

@end
