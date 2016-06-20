//
//  Home.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  首页
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 首页轮播图基本模型
@interface BaseModel : NSObject
/// 图片URL
@property (nonatomic, strong) NSString *photo;
/// 价格
@property (nonatomic, assign) CGFloat price;
/// 标题
@property (nonatomic, strong) NSString *title;
/// 类型
@property (nonatomic, assign) NSInteger type;
/// 目标ID
@property (nonatomic, assign) NSInteger target_id;
/// Webview的URL
@property (nonatomic, strong) NSString *page_url;
/// 位置
@property (nonatomic, assign) NSInteger position;
/// 通道
@property (nonatomic, strong) NSString *channel;
/// 开始时间
@property (nonatomic, strong) NSString *start_time;
/// 结束时间
@property (nonatomic, strong) NSString *end_time;

@end

/// 首页
@interface Home : NSObject

/// 抢鲜啦
@property (nonatomic, strong) NSMutableArray *qiangxian_product_list;
/// 手机商品列表
@property (nonatomic, strong) NSMutableArray *mobile_product_list;
/// 轮播图
@property (nonatomic, strong) NSMutableArray *rotation;
/// 享新客专享折扣
@property (nonatomic, strong) NSString *register_gift_desc;//   享新客专享折扣
/// 四合一商品标题
@property (nonatomic, strong) NSMutableArray *fourInOne_banner;
/// 试吃标题
@property (nonatomic, strong) NSMutableArray *foretaste_banner;
/// 是否为o2o模式
@property (nonatomic, assign) NSInteger is_o2o_initial;
/// 新的URL
@property (nonatomic, strong) NSString *nnew_url;
/// 摇一摇URL
@property (nonatomic, strong) NSString *shake_url;
/// 顶部标题
@property (nonatomic, strong) NSMutableArray *top_banner;
/// 库存是否存在
@property (nonatomic, assign) NSInteger is_store_exist;
/// 标题
@property (nonatomic, strong) NSMutableArray *banner;
/// 特惠URL
@property (nonatomic, strong) NSString *perferential_url;
/// 水平商品标题
@property (nonatomic, strong) NSMutableArray *horizontal_product_banner;
/// 顶级URL
@property (nonatomic, strong) NSString *superior_url;

@end

