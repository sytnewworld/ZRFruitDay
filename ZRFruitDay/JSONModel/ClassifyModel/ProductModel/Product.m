//
//  Product.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品信息
//

#import "Product.h"
#import "MJExtension.h"

/// 商品基本模型
@implementation ProductBase
/// 替换不同的属性名称
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"common_id"]) {
        return @"id";
    }
    return propertyName;
}

@end

/// 商品类型
@implementation ProductType



@end

/// 商品信息
@implementation Product


@end

/// 商品列表模型
@implementation ProductsList

@end

/// 商品页面内容
@implementation ProductDetail

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"photo" : @"RotationPhoto",
             @"items" : @"ProductThumbInfo"
             };
}

@end

/// 轮播图图片
@implementation RotationPhoto

@end

/// 商品信息概要
@implementation ProductThumbInfo
/// 替换不同的属性名称
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {

    if ([propertyName isEqualToString:@"common_id"]) {
        return @"id";
    }
    return propertyName;
}

@end

/// 评价数基本模型
@implementation Comments


@end

/// 商品评论数
@implementation ProductComments


@end

/// 轮播图拓展
@implementation BannerExtension


@end

/// 果实百科基本模型
@implementation FruitEatBase


@end

/// 商品页果实百科
@implementation ProductFruitEat

+ (NSDictionary *)mj_objectClassInArray {

    return @{
             @"main" : @"FruitEatBase",
             @"banner" : @"BannerExtension"
             };
}


@end