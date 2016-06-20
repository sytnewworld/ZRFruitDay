//
//  ZRCommonView.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  公共的视图
//

#import <UIKit/UIKit.h>

@protocol ZRCommonViewDelegate <NSObject>

- (void)barBack;

@end

@interface ZRCommonView : UIView

/// 粗细为0.5的分割线
+ (UIView *)generateSeperatorLineWithOriginX:(CGFloat)xPoint originY:(CGFloat)yPoint width:(CGFloat)width direction:(NSInteger)direction;

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
+ (UIView *)generateSeperatorLineWithOriginX:(CGFloat)xPoint originY:(CGFloat)yPoint width:(CGFloat)width thickness:(CGFloat)thickness lineColor:(UIColor *)lineColor direction:(NSInteger)direction;
/// 自定义NavigaionBar
+ (UIView *)customNavigationBarWithDelegate:(id<ZRCommonViewDelegate>)delegate;
/// 自定义NavigationBar:返回图标、标题
+ (UIView *)customNavigationBarWithDelegate:(id<ZRCommonViewDelegate>)delegate backIconImage:(UIImage *)image title:(NSString *)title;
/**
 *  自定义星级图标
 *
 *  @param iconOrigin 图标在整个view的原点坐标
 *  @param iconWidth  每个图标的宽度，高度与其相同
 *  @param space      每个图标之间的间距
 *  @param level      图标层级
 *
 *  @return 相应的星级图标
 */
+ (UIView *)customStarIconViewWithOrigin:(CGPoint)iconOrigin IconWidth:(CGFloat)iconWidth iconSpace:(CGFloat)space level:(NSInteger)level;

/**
 *  画直方图
 *
 *  @param frame      矩形的起始坐标，不包含高度
 *  @param percentage 百分比
 *
 *  @return 百分比对应的矩形图
 */
+ (UIView *)drawHistogramWithFrame:(CGRect)frame percentage:(CGFloat)percentage;
/// 自定义弹出窗口 标题均为“温馨提示”且仅有一个按钮
+ (UIAlertView *)customAlertViewWithMessage:(NSString *)message;

@end
