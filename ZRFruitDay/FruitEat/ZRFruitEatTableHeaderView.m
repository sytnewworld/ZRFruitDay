//
//  ZRFruitEatTableHeaderView.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/4.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRFruitEatTableHeaderView.h"
#import "CommonDefines.h"
#import "UIColor+ZRAddition.h"
#import "ZRTopButtonModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ZRScale.h"
#import "UIButton+WebCache.h"

@interface ZRFruitEatTableHeaderView ()<UIScrollViewDelegate,UISearchBarDelegate>


/// 顶部六个标题按钮的数据
@property (nonatomic, strong) NSMutableArray *topButtonData;
/// 果食所有内容
@property (nonatomic, strong) FruitEat *fruitEatData;

/// 轮播图
@property (nonatomic, strong) UIScrollView *rotationScrollView;
/// 显示当前轮播图的页码
@property (nonatomic, strong) UILabel *currentPageLabel;
/// 当前页码数
@property (nonatomic, assign) NSInteger currentPage;
/// 总共的页码数
@property (nonatomic, assign) NSInteger totalPage;

/// 是否拖动
@property (nonatomic, assign) BOOL isDragging;
/// 定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZRFruitEatTableHeaderView

+ (ZRFruitEatTableHeaderView *)fruitEatTableHeaderViewWithFrame:(CGRect)frame TopButtonData:(NSMutableArray *)topButtonData fruitEatData:(FruitEat *)fruitEatData {

    ZRFruitEatTableHeaderView *fruitEatTableHeaderView = [[ZRFruitEatTableHeaderView alloc] initWithFrame:frame];
    fruitEatTableHeaderView.topButtonData = [topButtonData copy];
    fruitEatTableHeaderView.fruitEatData = fruitEatData;
    [fruitEatTableHeaderView buildTableHeaderView];
    return fruitEatTableHeaderView;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        _isDragging = NO;
        _currentPage = 1;
        _totalPage = 0;
    }
    return self;
}

#pragma mark - Build UI
/// 搭建TableHeaderView视图
- (void)buildTableHeaderView {
    
    // 搜索
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 45.0)];
    searchBar.placeholder = @"输入你感兴趣的关键字搜索";
    searchBar.delegate = self;
    searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    searchBar.barTintColor = [UIColor zr_colorFromHex:0xe1e2e4];
    [self addSubview:searchBar];
    
    [self buildrotationScrollView];
    [self buildTopTitleButton];
}

/// 轮播图
- (void)buildrotationScrollView {
    
    NSMutableArray *rotationData = [self.fruitEatData.banner copy];
    //  总共的页码数
    _totalPage = rotationData.count;
    
    CGFloat height = 115.0;
    //  轮播图ScrollView
    self.rotationScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 45.0, SCREEN_WIDTH, height)];
    _rotationScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (_totalPage + 2), height);
    _rotationScrollView.showsHorizontalScrollIndicator = NO;
    _rotationScrollView.pagingEnabled = YES;
    _rotationScrollView.delegate = self;
    [self addSubview:_rotationScrollView];
    
    //  添加轮播图片
    NSInteger i = 0;
    for (TopRotation *topRotation in rotationData) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (i + 1), 0.0, SCREEN_WIDTH, height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:topRotation.photo]];
        [_rotationScrollView addSubview:imageView];
        i++;
    }
    
    TopRotation *leftRotation = [rotationData objectAtIndex:_totalPage - 1];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, height)];
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:leftRotation.photo]];
    [_rotationScrollView addSubview:leftImageView];
    
    TopRotation *rightRotation = [rotationData objectAtIndex:0];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (_totalPage + 1), 0.0, SCREEN_WIDTH, height)];
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:rightRotation.photo]];
    [_rotationScrollView addSubview:rightImageView];
    
    //  当前图片页码显示
    self.currentPageLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45.0 - 15.0, height - 15.0 - 15.0, 15.0, 15.0)];
    _currentPageLabel.font = [UIFont systemFontOfSize:15.0];
    _currentPageLabel.textColor = COLOR_TITLE;
    [self addSubview:_currentPageLabel];
}

/// 顶部六个标题按钮
- (void)buildTopTitleButton {
    
    CGFloat width = (SCREEN_WIDTH - 1.0 * 2)/3;
    CGFloat height = 189.0/2;
    
    
    //  使用Button自带的图片和标题共同显示的方法
    for (NSInteger i = 0; i < 6; i++) {
        ButtonBase *buttonBaseData = [self.topButtonData objectAtIndex:i];
        NSInteger row = i/3;
        NSInteger line = i % 3;
        CGFloat xOrigin = (width + 1) * line;
        CGFloat yOrigin = CGRectGetMaxY(_rotationScrollView.frame) + (height + 1) * row;
        UIButton *button;
        if (i == 0) {
            NSString *title = [NSString stringWithFormat:@"%@", buttonBaseData.name];
            button = [self buildTopButtonWithFrame:CGRectMake(xOrigin, yOrigin, width, height) title:title imageURL:buttonBaseData.photo Tag:(11 + i) imageHeight:56.0];
        }else {
            NSString *title = [NSString stringWithFormat:@"%@\n%@", buttonBaseData.name, buttonBaseData.num];
            button = [self buildTopButtonWithFrame:CGRectMake(xOrigin, yOrigin, width, height) title:title imageURL:buttonBaseData.photo Tag:(11 + i) imageHeight:40.0];
        }
        [self addSubview:button];
    }
}

#pragma mark - Private Methods
/// 生成顶部标题按钮
- (UIButton *)buildTopButtonWithFrame:(CGRect)frame title:(NSString *)title imageURL:(NSString *)imageURL Tag:(NSInteger)tag imageHeight:(CGFloat)imageHeight {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.tag = tag;
    button.backgroundColor = [UIColor whiteColor];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:COLOR_GRAY_TITLE forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11.0];
    button.titleLabel.numberOfLines = 0;
    
    CGFloat height = imageHeight;
    
    [button sd_setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            [button setImage:[image scaleToSize:CGSizeMake(height, height)] forState:UIControlStateNormal];
        }
    }];
    
    button.imageView.backgroundColor = [UIColor whiteColor];
    button.titleLabel.backgroundColor = [UIColor whiteColor];
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat yOrigin = (button.frame.size.height - height - 5.0 - button.titleLabel.frame.size.height)/2;
    
    //  移动图片和标题文字，使其均居中
    [button setImageEdgeInsets:UIEdgeInsetsMake(yOrigin, (CGRectGetWidth(frame) - height)/2, 0.0, 0.0)];
    CGFloat titleWidth = button.titleLabel.frame.size.width;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(yOrigin + height + 5.0, CGRectGetWidth(button.frame)/2 - (height + titleWidth/2), 0.0, 0.0)];
    
    [button addTarget:self action:@selector(clickTopTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Actions
/// 响应顶部标题按钮
- (void)clickTopTitleButton:(UIButton *)button {
    
    
}

/// 改变顶部轮播图的初始偏移位置
- (void)changeScrollViewContentOffset {

    [_rotationScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0.0) animated:NO];
}

/// 开启定时器
- (void)timerStart {

    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/// 停止定时器
- (void)timerStop {

    [_timer invalidate];
}

/// 响应定时器,轮播图片内容
- (void)update:(NSTimer *)timer {

    if (_isDragging) {
        return;
    }

    CGPoint offset = _rotationScrollView.contentOffset;
    offset.x += SCREEN_WIDTH;
    [_rotationScrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
//  开始滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.rotationScrollView) {
        _isDragging = YES;
    }
}

//  停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.rotationScrollView) {
        _isDragging = NO;
    }
}

//  滚动过程中每像素调用一次方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.rotationScrollView) {
        //  修改轮播图当前页码和图片位置
        CGFloat xOffset = scrollView.contentOffset.x;
        _currentPage = (xOffset - SCREEN_WIDTH/2)/SCREEN_WIDTH;
        if (_currentPage > (_totalPage - 1) || _currentPage < 1) {
            _currentPageLabel.text = @"1";
        }else {
            _currentPageLabel.text = [NSString stringWithFormat:@"%ld", _currentPage + 1];
        }
        
        if (xOffset <= 0) {
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _totalPage, 0.0) animated:NO];
        }
        
        if (xOffset >= SCREEN_WIDTH * (_totalPage + 1)) {
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0.0) animated:NO];
        }
    }
}

@end
