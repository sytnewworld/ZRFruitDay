//
//  ZRHomeCollectionViewCell.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/20.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseModel;

@interface ZRHomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray *baseModelArray;     //  cell的数据内容
@property (nonatomic, strong) BaseModel *baseModel;               //  cell的数据

@end
