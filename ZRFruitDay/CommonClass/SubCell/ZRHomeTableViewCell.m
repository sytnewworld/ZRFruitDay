//
//  ZRHomeTableViewCell.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/20.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  首页自定义cell
//

#import "ZRHomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonDefines.h"
#import "Home.h"

#define PHOTO_HEIGHT     115.0

@interface ZRHomeTableViewCell ()

@property (nonatomic, strong) UIImageView *singleImageView;     //  单个视图

@property (nonatomic, strong) UIImageView *firstInThreeImageView;
@property (nonatomic, strong) UIImageView *secondInThreeImageView;
@property (nonatomic, strong) UIImageView *thirdInThreeImageView;

@property (nonatomic, strong) UIImageView *firstImageView;      //  第一个视图
@property (nonatomic, strong) UIImageView *secondImageView;     //  第二个视图
@property (nonatomic, strong) UIImageView *thirdImageView;      //  第三个视图
@property (nonatomic, strong) UIImageView *fourthImageView;     //  第四个视图

@end

@implementation ZRHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        if ([reuseIdentifier isEqualToString:@"cellSingleIdentifier"]) {
            [self buildSingleView];
        }else if ([reuseIdentifier isEqualToString:@"cellThreeInOneIdentifier"]) {
            [self buildThreeInOne];
        }else if ([reuseIdentifier isEqualToString:@"cellFourInOneIdentifier"]) {
            [self buildFourInOne];
        }
    }
    return self;
}

#pragma mark - BuildView
/// 自定义cellView
- (void)buildCellView {
    
}

/// 单个视图
- (void)buildSingleView {
    
    //  只加载第一个视图
    self.singleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0, 0.0, SCREEN_WIDTH - 6.0 * 2, PHOTO_HEIGHT)];
    _singleImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_singleImageView];
    [self buildSeperatorLineWithHeight:115.0];
    
    UIControl *control = [[UIControl alloc] initWithFrame:_singleImageView.bounds];
    [control addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    control.tag = 1;
    [_singleImageView addSubview:control];
}

/// 三合一视图
- (void)buildThreeInOne {
    
    CGFloat width = SCREEN_WIDTH - 6.0 * 2 - 2.0 * 2;
    //  加载前三个视图
    self.firstInThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0, 0.0, width/3, 150.0)];
    _firstInThreeImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_firstInThreeImageView];
    UIControl *firstControl = [[UIControl alloc] initWithFrame:_firstInThreeImageView.bounds];
    firstControl.tag = 31;
    [firstControl addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    [_firstInThreeImageView addSubview:firstControl];
    
    self.secondInThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_firstInThreeImageView.frame) + 2.0, 0.0, width/3, 150.0)];
    _secondInThreeImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_secondInThreeImageView];
    UIControl *secondControl = [[UIControl alloc] initWithFrame:_secondInThreeImageView.bounds];
    secondControl.tag = 32;
    [secondControl addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    [_secondInThreeImageView addSubview:secondControl];
    
    self.thirdInThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondInThreeImageView.frame) + 2.0, 0.0, width/3, 150.0)];
    _thirdInThreeImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_thirdInThreeImageView];
    UIControl *thirdControl = [[UIControl alloc] initWithFrame:_thirdInThreeImageView.bounds];
    thirdControl.tag = 33;
    [thirdControl addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    [_thirdInThreeImageView addSubview:thirdControl];
    [self buildSeperatorLineWithHeight:150.0];
}

/// 四合一视图
- (void)buildFourInOne {
    
    //  加载四个视图
    self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0, 0.0, SCREEN_WIDTH - 6.0 * 2, 100.0)];
    _firstImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_firstImageView];
    UIControl *firstInFourControl = [[UIControl alloc] initWithFrame:_firstImageView.bounds];
    firstInFourControl.tag = 41;
    [firstInFourControl addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    [_firstImageView addSubview:firstInFourControl];
    
    self.secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.0, CGRectGetMaxY(_firstImageView.frame) + 2.0, 125.0, 170.0)];
    _secondImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_secondImageView];
    UIControl *secondInFourControl = [[UIControl alloc] initWithFrame:_secondImageView.bounds];
    secondInFourControl.tag = 42;
    [secondInFourControl addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    [_secondImageView addSubview:secondInFourControl];
    
    self.thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondImageView.frame) + 2.0, CGRectGetMaxY(_firstImageView.frame) + 2.0, 182.0, 84.0)];
    _thirdImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_thirdImageView];
    UIControl *thirdInFourControl = [[UIControl alloc] initWithFrame:_thirdImageView.bounds];
    thirdInFourControl.tag = 43;
    [thirdInFourControl addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    [_thirdImageView addSubview:thirdInFourControl];
    
    self.fourthImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondImageView.frame) + 2.0, CGRectGetMaxY(_thirdImageView.frame) + 2.0, 182.0, 84.0)];
    _fourthImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_fourthImageView];
    [self buildSeperatorLineWithHeight:170.0 + 2.0 + 100.0];
    UIControl *fourthInFourControl = [[UIControl alloc] initWithFrame:_fourthImageView.bounds];
    fourthInFourControl.tag = 44;
    [fourthInFourControl addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    [_fourthImageView addSubview:fourthInFourControl];
}

/// 在每个cell上为整个图片添加边框线  height : 该cell上的所有图片的总高度
- (void)buildSeperatorLineWithHeight:(CGFloat)height {

    UIView *topView = [self generateSeperatorLineWithOriginX:6.0 originY:0.0 width:SCREEN_WIDTH - 6.0 * 2 direction:0];
    [self.contentView addSubview:topView];
    
    UIView *leftView = [self generateSeperatorLineWithOriginX:6.0 originY:0.0 width:height direction:1];
    [self.contentView addSubview:leftView];
    
    UIView *bottomView = [self generateSeperatorLineWithOriginX:6.0 originY:height width:SCREEN_WIDTH - 6.0 * 2 direction:0];
    [self.contentView addSubview:bottomView];
    
    UIView *rightView = [self generateSeperatorLineWithOriginX:SCREEN_WIDTH - 6.0 originY:0.0 width:height direction:1];
    [self.contentView addSubview:rightView];
}

#pragma mark - Private Methods
- (void)setCellType:(ZRHomeCellType)cellType {

    _cellType = cellType;
    if (self.cellType == ZRHomeCellTypeSingle) {
        BaseModel *base = [self.baseModelArray objectAtIndex:0];
        [self.singleImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
    }else if (self.cellType == ZRHomeCellTypeThreeInOne) {
        for (NSInteger i = 0; i < 3; i++) {
            BaseModel *base = [self.baseModelArray objectAtIndex:i];
            if (i == 0) {
                [self.firstInThreeImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
            }else if (i == 1) {
                [self.secondInThreeImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
            }else {
                [self.thirdInThreeImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
            }
        }
    }else {
        for (NSInteger i = 0; i < 4; i++) {
            BaseModel *base = [_baseModelArray objectAtIndex:i];
            if (i == 0) {
                [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
            }else if (i == 1) {
                [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
            }else if (i == 2) {
                [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
            }else {
                [self.fourthImageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
            }
        }
    }
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

#pragma mmark - Actions
- (void)clickControl:(UIControl *)control {

    BaseModel *base;
    if (_cellType == ZRHomeCellTypeSingle) {
        base = [self.baseModelArray objectAtIndex:0];
    }else if (_cellType == ZRHomeCellTypeThreeInOne) {
        if (control.tag == 31) {
            base = [self.baseModelArray objectAtIndex:0];
        }else if (control.tag == 32) {
            base = [self.baseModelArray objectAtIndex:1];
        }else if (control.tag == 33) {
            base = [self.baseModelArray objectAtIndex:2];
        }
    }else if (_cellType == ZRHomeCellTypeFourInOne) {
        if (control.tag == 41) {
            base = [self.baseModelArray objectAtIndex:0];
        }else if (control.tag == 42) {
            base = [self.baseModelArray objectAtIndex:1];
        }else if (control.tag == 43) {
            base = [self.baseModelArray objectAtIndex:2];
        }else if (control.tag == 44) {
            base = [self.baseModelArray objectAtIndex:3];
        }
    }
    self.clickCell(base.page_url);
}

@end
