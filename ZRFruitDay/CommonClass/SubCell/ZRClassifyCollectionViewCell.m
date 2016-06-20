//
//  ZRClassifyCollectionViewCell.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRClassifyCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface ZRClassifyCollectionViewCell ()

/// item的图片
@property (nonatomic, strong) UIImageView *itemIcon;
/// item的名称
@property (nonatomic, strong) UILabel *itemName;

@end

@implementation ZRClassifyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self buildCollectionViewCell];
    }
    return self;
}

/// 初始化CollectionViewCell的视图
- (void)buildCollectionViewCell {

    self.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.bounds.size.width;
    //  图片65 * 65
    self.itemIcon = [[UIImageView alloc] initWithFrame:CGRectMake((width - 65.0)/2, 2.0, 65.0, 65.0)];
    [self addSubview:_itemIcon];
    
    //  名称
    self.itemName = [[UILabel alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_itemIcon.frame) + 1.0, width, 14.0)];
    _itemName.font = [UIFont systemFontOfSize:13.0];
    _itemName.textColor = [UIColor blackColor];
    _itemName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_itemName];
}

/// 刷新CollectionViewCell数据
- (void)setSubClassify:(SubClassify *)subClassify {

    _subClassify = subClassify;
    
    [self.itemIcon sd_setImageWithURL:[NSURL URLWithString:_subClassify.class_photo]];
    self.itemName.text = _subClassify.name;
}

@end
