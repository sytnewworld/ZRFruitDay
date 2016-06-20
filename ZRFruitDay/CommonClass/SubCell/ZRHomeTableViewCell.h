//
//  ZRHomeTableViewCell.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/20.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  首页自定义cell
//  

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,  ZRHomeCellType) {
    
    ZRHomeCellTypeSingle = 0,       //  只有一个图片
    ZRHomeCellTypeThreeInOne,       //  三个图片放在一个cell里
    ZRHomeCellTypeFourInOne         //  四个图片放在一个cell里
};

typedef void(^ClickCell)(NSString *page_url);

@interface ZRHomeTableViewCell : UITableViewCell

@property (nonatomic, assign) ZRHomeCellType cellType;
@property (nonatomic, strong) NSMutableArray *baseModelArray;   //  cell的数据内容

@property (nonatomic, strong) ClickCell clickCell;

@end
