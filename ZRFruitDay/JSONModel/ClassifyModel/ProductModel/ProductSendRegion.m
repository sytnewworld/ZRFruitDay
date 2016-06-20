//
//  ProductSendRegion.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/28.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品配送区域和日期信息
//

#import "ProductSendRegion.h"
#import "MJExtension.h"

/// 地区基本模型
@implementation RegionBase

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {

    if ([propertyName isEqualToString:@"common_id"]) {
        return @"id";
    }
    return propertyName;
}

@end

/// 地区信息
@implementation Region


@end

/// 区域和日期信息模型
@implementation ProductSendMessage


@end

/// 获取商品配送区域和日期所有信息
@implementation ProductSendRegion


@end
