//
//  ZRTopButtonModel.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/4.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  果食页面顶部按钮的模型
//

#import <UIKit/UIKit.h>
#import "FruitEat.h"

typedef NS_ENUM(NSInteger, FruitEatTopButtonType) {

    FruitEatTopButtonTypeOneLabel = 0,
    FruitEatTopButtonTypeTwoLabel
};

@interface ZRTopButtonModel : UIView

/**
 *  自定义TopButtonModel
 *
 *  @param frame         按钮的frame
 *  @param buttonBase    数据模型
 *  @param topButtonType 按钮类型
 *
 *  @return 生成的自定义按钮
 */
+ (ZRTopButtonModel *)buildTopButtonModelWithFrame:(CGRect)frame buttonBase:(ButtonBase *)buttonBase topButtonType:(FruitEatTopButtonType)topButtonType tag:(NSInteger)tag;

@end
