//
//  ZRCommentsDetailCell.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品评价详情页cell
//

#import <UIKit/UIKit.h>
#import "CommentsDetail.h"

/**
 *  回调Block，展示商品晒图的大图
 *
 *  @param index 当前点击的第几张晒图
 */
typedef void(^ShowWholeImageView)(NSInteger index);

@interface ZRCommentsDetailCell : UITableViewCell

/// 商品评价详情
@property (nonatomic, strong) CommentsDetail *commentsDetail;
/// 展示商品晒图的大图
@property (nonatomic, copy) ShowWholeImageView showWholeImageView;

@end
