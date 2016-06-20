//
//  ZRFruitEatTableHeaderView.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/4.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FruitEat.h"

@protocol ZRFruitEatTableHeaderViewDelegate <NSObject>



@end

@interface ZRFruitEatTableHeaderView : UIView

/// 代理
@property (nonatomic, weak) id<ZRFruitEatTableHeaderViewDelegate> delegate;

/**
 *  TableView顶部视图
 *
 *  @param frame         位置
 *  @param topButtonData 顶部按钮数据
 *  @param fruitEatData  所有数据
 *
 *  @return 得到的顶部视图
 */
+ (ZRFruitEatTableHeaderView *)fruitEatTableHeaderViewWithFrame:(CGRect)frame TopButtonData:(NSMutableArray *)topButtonData fruitEatData:(FruitEat *)fruitEatData;

/// 改变顶部轮播图的初始偏移位置
- (void)changeScrollViewContentOffset;
/// 开启定时器
- (void)timerStart;
/// 停止定时器
- (void)timerStop;

@end

