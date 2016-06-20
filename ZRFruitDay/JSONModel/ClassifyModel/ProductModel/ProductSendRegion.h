//
//  ProductSendRegion.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/28.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品配送区域和日期信息
//

#import <Foundation/Foundation.h>

/// 地区基本模型
@interface RegionBase : NSObject

/// 区域ID
@property (nonatomic, strong) NSString *common_id;
/// 区域名称
@property (nonatomic, strong) NSString *name;

@end

/// 地区信息
@interface Region : NSObject

/// 省份
@property (nonatomic, strong) RegionBase *province;
/// 城市
@property (nonatomic, strong) RegionBase *city;
/// 地区
@property (nonatomic, strong) RegionBase *area;

@end

/// 区域和日期信息模型
@interface ProductSendMessage : NSObject

/// 是否能购买
@property (nonatomic, assign) NSInteger can_buy;
/// 配送时间描述
@property (nonatomic, strong) NSString *send_desc;
/// 配送区域
@property (nonatomic, strong) Region *area_info;

@end

/// 获取商品配送区域和日期所有信息
@interface ProductSendRegion : NSObject

/// 编码
@property (nonatomic, strong) NSString *code;
/// 区域和日期信息
@property (nonatomic, strong) ProductSendMessage *msg;

@end


