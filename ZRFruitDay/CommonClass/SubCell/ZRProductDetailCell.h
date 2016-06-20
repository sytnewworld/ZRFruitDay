//
//  ZRProductDetailCell.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/27.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品详细信息
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductSendRegion.h"

@protocol ZRProductDetailCellDelegate <NSObject>

@optional
/// 点击图片跳转至其相应的WebView界面
- (void)showWebViewDetailWithPageURL:(NSString *)pageURL;

@end

/**
 *  点击商品数量加减,返回数量
 *
 *  @param button     点击按钮(增加或减少)
 *  @param productNum 商品数量
 *
 *  @return 改变后的商品数量
 */
typedef NSInteger(^ChangeProductNumWithButton)(UIButton *button,NSInteger productNum);

@interface ZRProductDetailCell : UITableViewCell

/// 商品基本信息
@property (nonatomic, strong) ProductDetail *productDetail;
/// 商品配送信息
@property (nonatomic, strong) ProductSendMessage *productSendMessage;
/// 商品评价信息
@property (nonatomic, strong) ProductComments *productComments;
/// 商品页果实百科
@property (nonatomic, strong) ProductFruitEat *productFruitEat;

/// 代理
@property (nonatomic, weak) id<ZRProductDetailCellDelegate> delegate;
/// 声明Block
@property (nonatomic, copy) ChangeProductNumWithButton changeProductNumWithButton;

@end
