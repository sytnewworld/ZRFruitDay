//
//  ZRProductDetailCell.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/27.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品详细信息
//

#import "ZRProductDetailCell.h"
#import "ZRCommonView.h"
#import "UIImageView+WebCache.h"
#import "CommonDefines.h"

@interface ZRProductDetailCell ()

/// 商品名称
@property (nonatomic, strong) UILabel *productNameLabel;
/// 商品数量显示
@property (nonatomic, strong) UILabel *numLabel;
/// 商品价格
@property (nonatomic, strong) UILabel *productPriceLabel;
/// 商品规格
@property (nonatomic, strong) UILabel *productVolumeLabel;
/// 配送区域
@property (nonatomic, strong) UILabel *productSendRegionLabel;
/// 配送时间
@property (nonatomic, strong) UILabel *productSendDataLabel;
/// 商品评价
@property (nonatomic, strong) UILabel *productCommentsLabel;
/// 果实百科 ———— 图片
@property (nonatomic, strong) UIImageView *fruitEatIconImageView;
/// 果实百科 ———— 头标题
@property (nonatomic, strong) UILabel *fruitEatTitleLabel;
/// 果实百科 ———— 描述
@property (nonatomic, strong) UILabel *fruitEatDescriptionLabel;
/// 热门推荐
@property (nonatomic, strong) UIImageView *hotProductImageView;

@end

@implementation ZRProductDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellViewWithIdentifier:reuseIdentifier];
    }
    return self;
}

#pragma mark - Private Methods
- (void)buildCellViewWithIdentifier:(NSString *)identifier {
   
    if ([identifier isEqualToString:@"ProductInformationCellIdentifier"]) {
        [self buildProductInformationViewForCell];
    }else if ([identifier isEqualToString:@"ProductVolumeCellIdentifier"]) {
        [self buildProductVolumeViewForCell];
    }else if ([identifier isEqualToString:@"ProductSendCellIdentifier"]) {
        [self buildProductSendRegionViewForCell];
    }else if ([identifier isEqualToString:@"ProductCommentsCellIdentifier"]) {
        [self buildProductCommentsViewForCell];
    }else if ([identifier isEqualToString:@"ProductFruitEatCellIdentifier"]) {
        [self buildFruitEatViewForCell];
    }else if ([identifier isEqualToString:@"ProductHotCellIdentifier"]) {
        [self buildHotProductViewForCell];
    }
}

/// cell的标题 ———— 统一显示:15号加租字体，黑色
- (UILabel *)customLabel {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 16.0, 15.0 * 4, 15.0)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

#pragma mark - 加载cell数据
/// 刷新cell的数据
- (void)setProductDetail:(ProductDetail *)productDetail {

    _productDetail = productDetail;
    [self loadProductInformationData];
}

/// 更新商品信息数据
- (void)loadProductInformationData {
    
    //  商品信息概要
    ProductThumbInfo *productThumbInfo = [self.productDetail.items objectAtIndex:0];
    if ([self.reuseIdentifier isEqualToString:@"ProductInformationCellIdentifier"]) {
        //  商品名称
        self.productNameLabel.text = self.productDetail.product.product_name;
        //  商品价格
        self.productPriceLabel.text = [NSString stringWithFormat:@"¥%.2f",[productThumbInfo.price floatValue]];
        //  价格富文本
        NSInteger length = self.productPriceLabel.text.length;
        NSString *string = self.productPriceLabel.text;
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
        [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0] range:NSMakeRange(1, length - 4)];
        self.productPriceLabel.attributedText = attrString;
    }else if ([self.reuseIdentifier isEqualToString:@"ProductVolumeCellIdentifier"]) {
        //  商品规格
        self.productVolumeLabel.text = productThumbInfo.volume;
    }else if ([self.reuseIdentifier isEqualToString:@"ProductSendCellIdentifier"]) {
        //  商品配送区域
        NSString *productSend = [NSString stringWithFormat:@"%@ %@ %@",self.productSendMessage.area_info.province.name,self.productSendMessage.area_info.city.name,self.productSendMessage.area_info.area.name];
        self.productSendRegionLabel.text = productSend;
        //  商品配送时间
        self.productSendDataLabel.text = self.productSendMessage.send_desc;
    }else if ([self.reuseIdentifier isEqualToString:@"ProductCommentsCellIdentifier"]) {
        //  商品评价
        self.productCommentsLabel.text = [NSString stringWithFormat:@"%ld％的果友给了",self.productComments.good];
    }else if ([self.reuseIdentifier isEqualToString:@"ProductFruitEatCellIdentifier"]) {
        //  商品页果实百科
        FruitEatBase *fruitEatBase = [self.productFruitEat.main objectAtIndex:0];
        //  图片
        [self.fruitEatIconImageView sd_setImageWithURL:[NSURL URLWithString:fruitEatBase.images_thumbs]];
        //  标题
        self.fruitEatTitleLabel.text = fruitEatBase.title;
        //  描述
        self.fruitEatDescriptionLabel.text = fruitEatBase.summary;
    }else if ([self.reuseIdentifier isEqualToString:@"ProductHotCellIdentifier"]) {
        //  热门推荐
        [self.hotProductImageView sd_setImageWithURL:[NSURL URLWithString:self.productDetail.banner.photo]];
    }
}

#pragma mark - Actions
/// 点击加减按钮时
- (void)clickButton:(UIButton *)button {

    NSInteger currentProductNum = [self.numLabel.text integerValue];
    NSInteger productNum = self.changeProductNumWithButton(button, currentProductNum);
    self.numLabel.text = [NSString stringWithFormat:@"%ld",productNum];
}

/// 展示WebView详情页或者跳转至对应商品详情页
- (void)showImageViewDetail {

    if (self.delegate && [self.delegate respondsToSelector:@selector(showWebViewDetailWithPageURL:)]) {
        [self.delegate showWebViewDetailWithPageURL:self.productDetail.banner.page_url];
    }
}

#pragma mark - BuildCellView
/// 商品信息视图 ———— 商品名称、价格、加减数量
- (void)buildProductInformationViewForCell {
    
    //  商品名称
    self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(11.0, 13.0, 253.0, 37.0)];
    _productNameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    _productNameLabel.textColor = [UIColor blackColor];
    _productNameLabel.numberOfLines = 2;
    [self.contentView addSubview:_productNameLabel];
    
    //  商品价格
    self.productPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(14.0, CGRectGetMaxY(_productNameLabel.frame) + 30.0, SCREEN_WIDTH - 14.0 - 106.0 - 8.0, 20.0)];
    _productPriceLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _productPriceLabel.textColor = COLOR_SPECIAL;
    [self.contentView addSubview:_productPriceLabel];
    
    //  加减按钮
    UIView *productNumControl = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 106.0 - 8.0, 63.0, 106.0, 36.0)];
    productNumControl.backgroundColor = [UIColor whiteColor];
    
    //  数量减少
    UIButton *reduceButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 36.0, 36.0)];
    reduceButton.layer.cornerRadius = 18.0;
    reduceButton.layer.borderColor = COLOR_SEPERATOR_LINE.CGColor;
    reduceButton.layer.borderWidth = .5f;
    reduceButton.tag = 10;
    [reduceButton setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
    [reduceButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [productNumControl addSubview:reduceButton];

    //  数量显示
    self.
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(reduceButton.frame), 0.0, 35.0, 36.0)];
    _numLabel.font = [UIFont systemFontOfSize:15.0];
    _numLabel.textColor = [UIColor blackColor];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.text = @"1";
    [productNumControl addSubview:_numLabel];
    
    //  数量增加
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numLabel.frame), 0.0, 36.0, 36.0)];
    addButton.layer.cornerRadius = 18.0;
    addButton.layer.borderColor = COLOR_SEPERATOR_LINE.CGColor;
    addButton.layer.borderWidth = .5f;
    addButton.tag = 99;
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    [productNumControl addSubview:addButton];

    [self.contentView addSubview:productNumControl];
}

/// 商品规格视图
- (void)buildProductVolumeViewForCell {
    
    UILabel *titleLabel = [self customLabel];
    titleLabel.text = @"规格";
    [self.contentView addSubview:titleLabel];
    
    self.productVolumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70.0 - 15.0, 10.0, 70.0, 25.0)];
    _productVolumeLabel.font = [UIFont systemFontOfSize:10.0];
    _productVolumeLabel.textColor = COLOR_SPECIAL;
    _productVolumeLabel.textAlignment = NSTextAlignmentCenter;
    _productVolumeLabel.layer.borderColor = COLOR_SPECIAL.CGColor;
    _productVolumeLabel.layer.borderWidth = .5;
    _productVolumeLabel.layer.cornerRadius = 3.0;
    [self.contentView addSubview:_productVolumeLabel];
}

/// 商品配送区域视图
- (void)buildProductSendRegionViewForCell {
    
    UILabel *titleLabel = [self customLabel];
    titleLabel.text = @"配送";
    [self.contentView addSubview:titleLabel];
    
    self.productSendRegionLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0 + 15.0 * 4, 18.0, 210.0, 15.0)];
    _productSendRegionLabel.font = [UIFont systemFontOfSize:15.0];
    _productSendRegionLabel.textColor = COLOR_HIGHLIGHT_GRAY_TITLE;
    _productSendRegionLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _productSendRegionLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_productSendRegionLabel];
    
    self.productSendDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0 + 15.0 * 4, 42.0, 210.0, 14.0)];
    _productSendDataLabel.font = [UIFont systemFontOfSize:14.0];
    _productSendDataLabel.textColor = COLOR_GRAY_TITLE;
    _productSendDataLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_productSendDataLabel];
}

/// 商品评价视图
- (void)buildProductCommentsViewForCell {
    
    UILabel *titleLabel = [self customLabel];
    titleLabel.text = @"商品评价";
    [self.contentView addSubview:titleLabel];
    
    self.productCommentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 36.0 - 76.0, 10.0, 76.0, 10.0)];
    _productCommentsLabel.font = [UIFont systemFontOfSize:10.0];
    _productCommentsLabel.textColor = COLOR_HIGHLIGHT_GRAY_TITLE;
    _productCommentsLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_productCommentsLabel];

    UIView *starIconView = [ZRCommonView customStarIconViewWithOrigin:CGPointMake(SCREEN_WIDTH - 66.0 - 36.0, 25.0) IconWidth:10.0 iconSpace:4.0 level:5];
    [self.contentView addSubview:starIconView];
}

/// 果实百科视图
- (void)buildFruitEatViewForCell {
    
    UILabel *titleLabel = [self customLabel];
    titleLabel.text = @"果实百科";
    [self.contentView addSubview:titleLabel];
    
    self.fruitEatIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, 47.0, 55.0, 55.0)];
    [self.contentView addSubview:_fruitEatIconImageView];
    
    self.fruitEatTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_fruitEatIconImageView.frame) + 11.0, 46.0, 210.0, 15.0)];
    _fruitEatTitleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _fruitEatTitleLabel.textColor = [UIColor blackColor];
    _fruitEatTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_fruitEatTitleLabel];
    
    self.fruitEatDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_fruitEatIconImageView.frame) + 11.0, CGRectGetMaxY(_fruitEatTitleLabel.frame), 210.0, 42.0)];
    _fruitEatDescriptionLabel.font = [UIFont systemFontOfSize:15.0];
    _fruitEatDescriptionLabel.textColor = COLOR_GRAY_TITLE;
    _fruitEatDescriptionLabel.numberOfLines = 2;
    _fruitEatDescriptionLabel.textAlignment = NSTextAlignmentLeft;
    _fruitEatDescriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_fruitEatDescriptionLabel];
}

/// 热门推荐视图
- (void)buildHotProductViewForCell {
    
    UILabel *titleLabel = [self customLabel];
    titleLabel.text = @"热门推荐";
    [self.contentView addSubview:titleLabel];
    
    self.hotProductImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0, 30.0 + 12.0, SCREEN_WIDTH - 6.0 * 2, 121.0)];
    _hotProductImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_hotProductImageView];
    
    //  跳转至该图片所对应的WebView页面
    UIControl *showWebView = [[UIControl alloc] initWithFrame:self.hotProductImageView.bounds];
    [showWebView addTarget:self action:@selector(showImageViewDetail) forControlEvents:UIControlEventTouchUpInside];
    [_hotProductImageView addSubview:showWebView];
}

@end
