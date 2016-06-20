//
//  ZRHomeCollectionViewCell.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/20.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRHomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonDefines.h"
#import "Home.h"

#define PHOTO_HEIGHT     115.0

@interface ZRHomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *firstImageView;      //  第一个视图
@property (nonatomic, strong) UIImageView *secondImageView;     //  第二个视图
@property (nonatomic, strong) UIImageView *thirdImageView;      //  第三个视图
@property (nonatomic, strong) UIImageView *fourthImageView;     //  第四个视图

@end

@implementation ZRHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
        [self buildCollectionViewCell];
    }
    return self;
}

#pragma mark - Build View
///  cell的显示内容
- (void)buildCollectionViewCell {

//    switch (self.cellType) {
//        case 0:
//            [self buildSingleView];
//            break;
//        case 1:
//            [self buildThreeInOne];
//            break;
//        case 2:
//            [self buildFourInOne];
//            break;
//        default:
//            break;
//    }
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_imageView];
}

/// 单个视图
- (void)buildSingleView {

    //  只加载第一个视图
    if (_firstImageView == nil) {
        self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH - 6.0 * 2, PHOTO_HEIGHT)];
        [self.contentView addSubview:_firstImageView];
    }
}

/// 三合一视图
- (void)buildThreeInOne {
    
    CGFloat width = SCREEN_WIDTH - 6.0 * 2 - 2.0 * 2;
    if (_secondImageView == nil) {
        //  加载前三个视图
        self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 150.0)];
        [self.contentView addSubview:_firstImageView];
        
        self.secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_firstImageView.frame) + 2.0, 0.0, width, 150.0)];
        [self.contentView addSubview:_secondImageView];
        
        self.thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondImageView.frame) + 2.0, 0.0, width, 150.0)];
        [self.contentView addSubview:_thirdImageView];
    }
}

/// 四合一视图
- (void)buildFourInOne {

    if (_fourthImageView == nil) {
        //  加载四个视图
        self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH - 6.0 * 2, 100.0)];
        [self.contentView addSubview:_firstImageView];
        
        self.secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_firstImageView.frame) + 2.0, 125.0, 170.0)];
        [self.contentView addSubview:_secondImageView];
        
        self.thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondImageView.frame) + 2.0, CGRectGetMaxY(_firstImageView.frame) + 2.0, 182.0, 84.0)];
        [self.contentView addSubview:_thirdImageView];
        
        self.fourthImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondImageView.frame) + 2.0, CGRectGetMaxY(_thirdImageView.frame) + 2.0, 182.0, 84.0)];
        [self.contentView addSubview:_fourthImageView];
    }
}

#pragma mark - Private Methods
- (void)setBaseModel:(BaseModel *)baseModel {

    _baseModel = baseModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_baseModel.photo]];
}

@end
