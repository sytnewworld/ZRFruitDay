//
//  Classify.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  分类
//  

#import "Classify.h"
#import "MJExtension.h"

/// 基本模型
@implementation ClassifyBaseModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"common_id"]) {
        return @"id";
    }
    return nil;
}

@end

/// 所有分类内容
@implementation Classify

+ (NSDictionary *)mj_objectClassInArray {

    return @{@"hot" : @"FirstClassify",
             @"common" : @"FirstClassify"};
}

@end

/// 一级分类
@implementation FirstClassify

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"sub_level" : @"SubClassify"};
}
@end

/// 二级分类
@implementation SubClassify


@end

