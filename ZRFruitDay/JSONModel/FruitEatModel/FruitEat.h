//
//  FruitEat.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  果食Model
//

#import <Foundation/Foundation.h>
#import "Home.h"

/// 顶部六个按钮的基本模型
@interface ButtonBase : NSObject

/// 通用id
@property (nonatomic, strong) NSString *common_id;
/// 名称
@property (nonatomic, strong) NSString *name;
/// 图片
@property (nonatomic, strong) NSString *photo;
/// 数目
@property (nonatomic, strong) NSString *num;
/// 子类
@property (nonatomic, strong) NSMutableArray *son;

@end

/// 顶部轮播图
@interface TopRotation : BaseModel

/// 是否为顶部
@property (nonatomic, strong) NSString *is_top;

@end

/// 最新发布内容
@interface ReleaseContent : NSObject

/// 通用id
@property (nonatomic, strong) NSString *common_id;
/// 标题
@property (nonatomic, strong) NSString *title;
/// 概要
@property (nonatomic, strong) NSString *summary;
/// 类型
@property (nonatomic, strong) NSString *type;
/// 图片
@property (nonatomic, strong) NSString *photo;
/// c时间
@property (nonatomic, strong) NSString *ctime;
/// 是否可评论
@property (nonatomic, strong) NSString *is_can_comment;
/// 图片数组
@property (nonatomic, strong) NSMutableArray *photo_arr;
/// 图片缩略图
@property (nonatomic, strong) NSString *images_thumbs;
/// 图片缩略图数组
@property (nonatomic, strong) NSMutableArray *images_thumbs_arr;
/// 分享链接
@property (nonatomic, strong) NSString *share_url;
/// s时间
@property (nonatomic, strong) NSString *stime;
/// 评论数
@property (nonatomic, strong) NSString *comment_num;
/// 点赞数
@property (nonatomic, strong) NSString *worth_num;
/// 收藏数
@property (nonatomic, strong) NSString *collection_num;
/// 点赞
@property (nonatomic, strong) NSString *is_worth;
/// 收藏
@property (nonatomic, strong) NSString *is_collect;

@end

/// 果食页面Model
@interface FruitEat : NSObject

/// 顶部
@property (nonatomic, strong) NSMutableArray *top;
/// 主体视图
@property (nonatomic, strong) NSMutableArray *main;
/// 轮播图
@property (nonatomic, strong) NSMutableArray *banner;

@end
