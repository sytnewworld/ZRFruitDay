//
//  Home.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  首页
//

#import "Home.h"
#import "MJExtension.h"

/// 首页基本模型
@implementation BaseModel


@end

/// 首页
@implementation Home

+ (NSDictionary *)mj_objectClassInArray {

    return @{
             @"top_banner" : @"BaseModel",
             @"rotation" : @"BaseModel",
             @"qiangxian_product_list" : @"BaseModel",
             @"mobile_product_list" : @"BaseModel",
             @"horizontal_product_banner" : @"BaseModel",
             @"fourInOne_banner" : @"BaseModel",
             @"foretaste_banner" : @"BaseModel",
             @"banner" : @"BaseModel"
             };
}

@end
