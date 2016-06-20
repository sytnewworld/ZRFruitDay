//
//  Product.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品信息
//

#import <Foundation/Foundation.h>
#import "Home.h"

/// 商品基本模型
@interface ProductBase : NSObject
/// 商品通用ID
@property (nonatomic, strong) NSString *common_id;
/// 商品名称
@property (nonatomic, strong) NSString *product_name;
/// 商品图片—— 缩略图
@property (nonatomic, strong) NSString *thum_photo;
/// 商品图片—— 大图
@property (nonatomic, strong) NSString *photo;
/// 商品描述
@property (nonatomic, strong) NSString *product_desc;
/// op详细位置
@property (nonatomic, strong) NSString *op_detail_place;
/// op大小
@property (nonatomic, strong) NSString *op_size;
/// 商品是否缺货 0: 缺货
@property (nonatomic, assign) NSInteger lack;
//
@property (nonatomic, strong) NSString *use_store;
/// 商品具体描述
@property (nonatomic, strong) NSString *prodcut_desc;

@end

/// 商品类型
@interface ProductType : NSObject

/// 热门
@property (nonatomic, assign) NSInteger hot;
/// 新品
@property (nonatomic, assign) NSInteger pnew;
/// 重要的
@property (nonatomic, assign) NSInteger import;
/// 销售量
@property (nonatomic, assign) NSInteger sale;
///
@property (nonatomic, assign) NSInteger yj;
///
@property (nonatomic, assign) NSInteger th;

@end

/// 商品信息
@interface Product : ProductBase

/// webview商品图文详情页
@property (nonatomic, strong) NSString *discription;
/// 配送区域
@property (nonatomic, strong) NSString *send_region;
/// 运费
@property (nonatomic, strong) NSString *free;
/// 消费者小贴士
@property (nonatomic, strong) NSString *consumer_tips;
///
@property (nonatomic, strong) NSString *op_place;
/// 标签id
@property (nonatomic, strong) NSString *tag_id;
/// 父类id
@property (nonatomic, strong) NSString *parent_id;
///
@property (nonatomic, strong) NSString *sweet;
///
@property (nonatomic, strong) NSString *store;
/// op重量
@property (nonatomic, strong) NSString *op_weight;

@end

/// 商品列表模型
@interface ProductsList : ProductBase

/// 商品图片—— 中等图
@property (nonatomic, strong) NSString *middle_photo;
/// 商品类型
@property (nonatomic, strong) ProductType *product_types;
/// 长图
@property (nonatomic, strong) NSString *long_photo;
/// op时机
@property (nonatomic, strong) NSString *op_occasion;
/// 商品摘要
@property (nonatomic, strong) NSString *summary;
/// 商品价格
@property (nonatomic, strong) NSString *price;
/// 商品移动端价格
@property (nonatomic, strong) NSString *mobile_price;
/// 商品体积
@property (nonatomic, strong) NSString *volume;
/// 商品价格ID
@property (nonatomic, strong) NSString *price_id;
/// 商品编号
@property (nonatomic, strong) NSString *product_no;
/// 商品ID
@property (nonatomic, strong) NSString *product_id;
/// 商品原价格
@property (nonatomic, strong) NSString *old_price;
/// 商品库存
@property (nonatomic, strong) NSString *stock;

@end

///  商品页面内容
@interface ProductDetail : NSObject

/// 商品信息
@property (nonatomic, strong) Product *product;
/// 商品所包含的子商品内容
@property (nonatomic, strong) NSMutableArray *items;
/// 轮播图图片
@property (nonatomic, strong) NSMutableArray *photo;
/// 分享链接
@property (nonatomic, strong) NSString *share_url;
/// 热门推荐页内容
@property (nonatomic, strong) BaseModel *banner;
/// 是否预售
@property (nonatomic, assign) NSInteger is_presell;

@end

///  轮播图图片
@interface RotationPhoto : NSObject

/// 缩略图
@property (nonatomic, strong) NSString *thum_photo;
/// 大图
@property (nonatomic, strong) NSString *photo;

@end

/// 商品信息概要
@interface ProductThumbInfo : NSObject

/// 通用id
@property (nonatomic, strong) NSString *common_id;
/// 商品价格
@property (nonatomic, strong) NSString *price;
/// 商品规格
@property (nonatomic, strong) NSString *volume;
/// 商品编号
@property (nonatomic, strong) NSString *product_no;
/// 商品ID
@property (nonatomic, strong) NSString *product_id;
/// 商品原价格
@property (nonatomic, strong) NSString *old_price;
/// 商品计量单位
@property (nonatomic, strong) NSString *unit;
/// 商品库存
@property (nonatomic, strong) NSString *stock;

@end

/// 评价数基本模型
@interface Comments : NSObject

/// 好评数
@property (nonatomic, assign) NSInteger good;
/// 一般数
@property (nonatomic, assign) NSInteger normal;
/// 差评数
@property (nonatomic, assign) NSInteger bad;
/// 评价总数
@property (nonatomic, assign) NSInteger total;

@end

/// 商品评论数
@interface ProductComments : Comments

/// 评价数
@property (nonatomic, strong) Comments *num;

@end

/// 轮播图拓展
@interface BannerExtension : BaseModel

/// 是否在顶部
@property (nonatomic, strong) NSString *is_top;

@end

/// 果实百科基本模型
@interface FruitEatBase : NSObject

/// 基本id
@property (nonatomic, strong) NSString *common_id;
/// 标题
@property (nonatomic, strong) NSString *title;
/// 综述
@property (nonatomic, strong) NSString *summary;
/// 类型
@property (nonatomic, strong) NSString *type;
/// 图片
@property (nonatomic, strong) NSString *photo;
/// C时间
@property (nonatomic, strong) NSString *ctime;
/// 是否可以评论
@property (nonatomic, strong) NSString *is_can_comment;
/// 图片数组
@property (nonatomic, strong) NSMutableArray *photo_arr;
/// 缩略图
@property (nonatomic, strong) NSString *images_thumbs;
/// 缩略图数组
@property (nonatomic, strong) NSMutableArray *images_thumbs_arr;
/// 分享链接
@property (nonatomic, strong) NSString *share_url;
/// S时间
@property (nonatomic, strong) NSString *stime;
/// 评论数
@property (nonatomic, assign) NSInteger comment_num;
/// 价值数量
@property (nonatomic, assign) NSInteger worth_num;
/// 收藏数量
@property (nonatomic, assign) NSInteger collection_num;
/// 是否有价值
@property (nonatomic, strong) NSString *is_worth;
/// 是否有人收藏
@property (nonatomic, strong) NSString *is_collect;

@end

/// 商品页果实百科
@interface ProductFruitEat : NSObject

/// 顶部
@property (nonatomic, strong) NSString *top;
/// 主体部分
@property (nonatomic, strong) NSMutableArray *main;
/// 轮播图
@property (nonatomic, strong) NSMutableArray *banner;

@end
