//
//  CommentsDetail.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品评价
//

#import <Foundation/Foundation.h>

/// 商品评价内容
@interface CommentsDetail : NSObject

/// 通用id
@property (nonatomic, strong) NSString *common_id;
/// 评价内容
@property (nonatomic, strong) NSString *content;
/// 评价时间
@property (nonatomic, strong) NSString *time;
/// 评价星级
@property (nonatomic, strong) NSString *star;
/// 评价人id
@property (nonatomic, strong) NSString *uid;
/// 评价人昵称
@property (nonatomic, strong) NSString *user_name;
/// 评价人头像
@property (nonatomic, strong) NSString *userface;
/// 顾客回复
@property (nonatomic, strong) NSMutableArray *customer_repaly;
/// 答复
@property (nonatomic, strong) NSString *reply;
/// 评价晒图
@property (nonatomic, strong) NSMutableArray *images;
/// 评价缩略图
@property (nonatomic, strong) NSMutableArray *thumbs;

@end
