//
//  FruitEat.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  果食Model
//

#import "FruitEat.h"
#import "MJExtension.h"

/// 顶部六个按钮的基本模型
@implementation ButtonBase

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {

    if ([propertyName isEqualToString:@"common_id"]) {
        return @"id";
    }
    return propertyName;
}

@end

/// 顶部轮播图
@implementation TopRotation

@end

/// 最新发布内容
@implementation ReleaseContent

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"common_id"]) {
        return @"id";
    }
    return propertyName;
}

@end

/// 果食页面Model
@implementation FruitEat

+ (NSDictionary *)mj_objectClassInArray {

    return @{
             @"main" : @"ReleaseContent",
             @"banner" : @"TopRotation"};
}

@end
