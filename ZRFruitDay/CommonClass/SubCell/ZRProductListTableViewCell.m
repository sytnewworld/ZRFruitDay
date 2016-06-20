//
//  ZRProductListTableViewCell.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品列表自定义TableViewCell
//

#import "ZRProductListTableViewCell.h"
#import "CommonDefines.h"
#import "UIImageView+WebCache.h"

@interface ZRProductListTableViewCell ()

/// 商品图片
@property (nonatomic, strong) UIImageView *productIcon;
/// 商品名称
@property (nonatomic, strong) UILabel *productName;
/// 商品体积
@property (nonatomic, strong) UILabel *productVolume;
/// 商品价格
@property (nonatomic, strong) UILabel *productPrice;
/// 购物车图标
@property (nonatomic, strong) UIImageView *cartIcon;

@end

@implementation ZRProductListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

#pragma mark - Private Methods 
/// 初始化TableViewCell视图
- (void)buildCellView {

    self.productIcon = [[UIImageView alloc] initWithFrame:CGRectMake(11.0, 11.0, 100.0, 100.0)];
    [self.contentView addSubview:_productIcon];
    
    self.productName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productIcon.frame) + 10.0, 12.0, SCREEN_WIDTH - CGRectGetMaxX(_productIcon.frame) - 10.0 - 11.0, 15.0)];
    _productName.font = [UIFont systemFontOfSize:15.0];
    _productName.textColor = [UIColor blackColor];
    [self.contentView addSubview:_productName];
    
    self.productVolume = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productIcon.frame) + 10.0, CGRectGetMaxY(_productName.frame) + 15.0, SCREEN_WIDTH - CGRectGetMaxX(_productIcon.frame) - 10.0 - 11.0, 12.0)];
    _productVolume.font = [UIFont systemFontOfSize:12.0];
    _productVolume.textColor = COLOR_GRAY_TITLE;
    [self.contentView addSubview:_productVolume];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productIcon.frame) + 10.0, CGRectGetMaxY(_productVolume.frame) + 36.0, SCREEN_WIDTH - CGRectGetMaxX(_productIcon.frame) - 10.0 - 43.0, 20.0)];
    _productPrice.font = [UIFont boldSystemFontOfSize:14.0];
    _productPrice.textColor = COLOR_SPECIAL;
    [self.contentView addSubview:_productPrice];
    
    UIView *lineView = [self generateSeperatorLineWithOriginX:9.0 originY:121.0 - 0.5 width:SCREEN_WIDTH - 9.0 - 5.0 direction:0];
    [self.contentView addSubview:lineView];
}

- (void)setProductsList:(ProductsList *)productsList {

    _productsList = productsList;
    [self loadCellData];
}

/// 加载cell数据
- (void)loadCellData {

    // 根据不同设备，设置不同大小的图片
    [self.productIcon sd_setImageWithURL:[NSURL URLWithString:self.productsList.middle_photo]];
    self.productName.text = self.productsList.product_name;
    self.productVolume.text = self.productsList.volume;
    self.productPrice.text = [NSString stringWithFormat:@"¥%@",self.productsList.price];
    //  价格富文本
    NSInteger length = self.productPrice.text.length;
    NSString *string = self.productPrice.text;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0] range:NSMakeRange(1, length - 4)];
    self.productPrice.attributedText = attrString;
}

/// 分割线
- (UIView *)generateSeperatorLineWithOriginX:(CGFloat)xPoint originY:(CGFloat)yPoint width:(CGFloat)width direction:(NSInteger)direction {
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_SEPERATOR_LINE;
    if (direction == 0) {
        //  direction == 0,水平
        lineView.frame = CGRectMake(xPoint, yPoint, width, 0.5);
    }else if (direction == 1) {
        //  direction == 1,垂直
        lineView.frame = CGRectMake(xPoint, yPoint, 0.5, width);
    }
    return lineView;
}

@end
