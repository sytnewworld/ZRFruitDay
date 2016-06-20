//
//  Classify.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  分类
//

#import <Foundation/Foundation.h>

/// 基本模型
@interface ClassifyBaseModel : NSObject
///  分类ID
@property (nonatomic, strong) NSString *common_id;
///  分类名称
@property (nonatomic, strong) NSString *name;
///  分类别名
@property (nonatomic, strong) NSString *ename;
///  分类是否为热卖
@property (nonatomic, assign) NSInteger is_hot;
///  分类图片
@property (nonatomic, strong) NSString *photo;
///  分类的类图片
@property (nonatomic, strong) NSString *class_photo;

@end

/// 所有分类内容
@interface Classify : NSObject

///  热门分类
@property (nonatomic, strong) NSMutableArray *hot;
///  通用分类
@property (nonatomic, strong) NSMutableArray *common;

@end

/// 一级分类
@interface FirstClassify : ClassifyBaseModel

///  二级分类列表
@property (nonatomic, strong) NSMutableArray *sub_level;

@end

/// 二级分类
@interface SubClassify : ClassifyBaseModel

///  父类ID
@property (nonatomic, strong) NSString *parent_id;
///  步数
@property (nonatomic, assign) NSInteger step;

@end
