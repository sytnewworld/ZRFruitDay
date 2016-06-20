//
//  CommentsDetail.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品评价
//

#import "CommentsDetail.h"
#import "MJExtension.h"
/// 商品评价内容
@implementation CommentsDetail

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"common_id"]) {
        return @"id";
    }
    return propertyName;
}

@end
