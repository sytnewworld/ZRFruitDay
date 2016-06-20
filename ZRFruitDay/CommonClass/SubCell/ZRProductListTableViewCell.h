//
//  ZRProductListTableViewCell.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品列表自定义TableViewCell
//

#import <UIKit/UIKit.h>
#import "Product.h"

/**
 *  转场动画，选中商品列表某一行时，跳转至它的商品详情页面
 *
 *  @param imageView 商品列表该行的商品图片
 */
typedef void(^ChangeViewWithAnimation)(UIImageView *imageView,CGFloat originY);

@interface ZRProductListTableViewCell : UITableViewCell

/// 传递cell数据
@property (nonatomic, strong) ProductsList *productsList;
/// Block的声明
@property (nonatomic, copy) ChangeViewWithAnimation changeViewWithAnimation;

@end
