//
//  ZRFruitEatTableViewCell.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  果食页面cell
//

#import <UIKit/UIKit.h>
#import "FruitEat.h"

@interface ZRFruitEatTableViewCell : UITableViewCell

/**
 *  果食页面cell
 *
 *  @param tableView      cell所在的TableView实例
 *  @param releaseContent 最新发布的模型实例
 *
 *  @return 生成的自定义cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ReleaseContent *)releaseContent;

/// ReleaseContent数据内容
@property (nonatomic, strong) ReleaseContent *releaseContentData;
/// cellType
@property (nonatomic, strong) NSString *cellType;
/// 是否点赞
@property (nonatomic, assign) BOOL isUpvote;

@end
