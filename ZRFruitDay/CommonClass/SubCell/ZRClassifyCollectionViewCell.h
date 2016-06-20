//
//  ZRClassifyCollectionViewCell.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Classify.h"

@interface ZRClassifyCollectionViewCell : UICollectionViewCell

/// 二级分类数据
@property (nonatomic, strong) SubClassify *subClassify;

@end
