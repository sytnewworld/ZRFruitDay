//
//  ZRCommentsDetailViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  评价详情页
//

#import "ZRCommentsDetailViewController.h"
#import "ZRHistogram.h"
#import "ZRCommentsDetailCell.h"
#import "CommentsDetail.h"

@interface ZRCommentsDetailViewController ()<ZRCommonViewDelegate,UITableViewDataSource,UITableViewDelegate>

/// 导航栏
@property (nonatomic, strong) UIView *navigationBarView;
/// 顶部评价概括视图
@property (nonatomic, strong) UIImageView *headerView;
/// 评价内容
@property (nonatomic, strong) UITableView *commentsTableView;
/// 评价内容数据
@property (nonatomic, strong) NSMutableArray *commentsDetailData;

/// 显示晒图大图的View
@property (nonatomic, strong) UIView *wholeView;
/// 显示第几张大图
@property (nonatomic, strong) UILabel *titleLabel;
/// 显示大图和评论的ScrollView
@property (nonatomic, strong) UIScrollView *imageScrollView;
/// 每个晒图的评论
@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation ZRCommentsDetailViewController {

    //  直方图
    ZRHistogram *histogramGood;
    ZRHistogram *histogramNormal;
    ZRHistogram *histogramBad;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {

    [super viewDidLoad];
    [self customNavigationBar];
    [self buildHeaderView];
    [self buildTableView];
    [self.view bringSubviewToFront:_navigationBarView];
    [self buildWholeView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self loadJsonData];
    [self.commentsTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    histogramGood.percentage = 96;
    histogramNormal.percentage = 3;
    histogramBad.percentage = 1;
}

#pragma mark - Build View 
/// 自定义导航栏
- (void)customNavigationBar {

    self.navigationBarView = [ZRCommonView customNavigationBarWithDelegate:self];
    [self.view addSubview:_navigationBarView];
}

/// 顶部评价概括视图
- (void)buildHeaderView {

    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 163.0)];
    [_headerView setImage:[UIImage imageNamed:@"晒单BG"]];
    [self.view addSubview:_headerView];
    
    histogramGood = [[ZRHistogram alloc] initWithFrame:CGRectMake(113.0, 34.0, 33.0, 121.0)];
    [self buildHistogram:histogramGood];
    histogramGood.textTitle = @"不错呦";
    [_headerView addSubview:histogramGood];
    
    histogramNormal = [[ZRHistogram alloc] initWithFrame:CGRectMake(113.0 + 20.0 + 51.0, 34.0, 33.0, 121.0)];
    [self buildHistogram:histogramNormal];
    histogramNormal.textTitle = @"待提高";
    [_headerView addSubview:histogramNormal];
    
    histogramBad = [[ZRHistogram alloc] initWithFrame:CGRectMake(259.0, 34.0, 33.0, 121.0)];
    [self buildHistogram:histogramBad];
    histogramBad.textTitle = @"小失落";
    [_headerView addSubview:histogramBad];
}

/// 设置直方图的颜色、文字标题颜色和大小、百分比标题颜色和大小
- (void)buildHistogram:(ZRHistogram *)histogram {

    [histogram setTextTitleLabelWithTextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:10.0]];
    [histogram setPercentTitleLabelWithTextColor:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:11.0]];
    [histogram setHistogramViewBackgroundColor:[UIColor whiteColor]];
}

/// 评价内容TableView
- (void)buildTableView {

    self.commentsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetHeight(_headerView.frame)) style:UITableViewStylePlain];
    _commentsTableView.dataSource = self;
    _commentsTableView.delegate = self;
    _commentsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.view addSubview:_commentsTableView];
}

/// 展示商品晒图的大图View
- (void)buildWholeView {

    self.wholeView = [[UIView alloc] initWithFrame:self.view.bounds];
    _wholeView.backgroundColor = [UIColor zr_colorFromHex:0x141414];
    [self.view addSubview:_wholeView];
    _wholeView.hidden = YES;
    
    //  大图标题 第几张图
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 65.0)];
//    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = COLOR_TITLE;
    _titleLabel.font = [UIFont systemFontOfSize:14.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_wholeView addSubview:_titleLabel];
    
    //  大图显示
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_titleLabel.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 65.0 - 38.0)];
    _imageScrollView.backgroundColor = [UIColor blackColor];
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    [_wholeView addSubview:_imageScrollView];
    
    //  每张晒图的评论内容
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(11.0, CGRectGetMaxY(_imageScrollView.frame) + 13.0, SCREEN_WIDTH - 11.0, SCREEN_HEIGHT - CGRectGetMaxY(_imageScrollView.frame))];
//    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.textColor = [UIColor whiteColor];
    _commentLabel.font = [UIFont systemFontOfSize:14.0];
    _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _commentLabel.numberOfLines = 0;
    [_wholeView addSubview:_commentLabel];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidesWholeView:)];
    [self.imageScrollView addGestureRecognizer:tapGestureRecognizer];
}

/// 展示商品晒图的大图 ———— 设置数据
- (void)showWholeImageViewWithImages:(CommentsDetail *)commentsDetail atIndex:(NSInteger)index {

    _wholeView.hidden = NO;
    NSLog(@"展示 %ld",index);
    //  所有晒图
    NSArray *images = commentsDetail.images;
    //  标题内容
    if (images.count <= 1) {
        _titleLabel.text = @"";
    }else {
        _titleLabel.text = [NSString stringWithFormat:@"%ld of %ld", index, images.count];
    }
    
    //  ScrollView的滚动范围大小
    _imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * images.count, CGRectGetHeight(_imageScrollView.frame));
    for (UIView *view in _imageScrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    NSInteger i = 0;
    //  ScrollView的图片内容
    for (NSString *string in images) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0.0, SCREEN_WIDTH, CGRectGetHeight(_imageScrollView.frame) - 38.0)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:string]];
        [_imageScrollView addSubview:imageView];
        i++;
    }
    //  当前位置的ScrollView的偏移量
    _imageScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (index - 1), 0.0);
    
    //  评论内容
    _commentLabel.text = commentsDetail.content;
    //  更改ScrollView的高度和评论内容的高度
    [self changeFrameHeight];
}

#pragma mark - Private  Methods
/// 重写父类方法
- (void)barBack {

    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 点击scrollView时隐藏该View
- (void)hidesWholeView:(UITapGestureRecognizer *)tapGestureRecognizer {

    self.wholeView.hidden = YES;
}

/// 更改frame高度
- (void)changeFrameHeight {

    //  获取当前cell的frame
    CGRect frame = [_imageScrollView frame];
    
    //  计算Label的高度
    CGSize size = CGSizeMake(CGRectGetWidth(_commentLabel.frame), 1000);
    CGSize labelSize = [self.commentLabel.text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:_commentLabel.font} context:nil].size;
    
    frame.size.height = SCREEN_HEIGHT - 65.0 - labelSize.height - 26.0;
    _imageScrollView.frame = frame;
    
    CGRect frameLabel = _commentLabel.frame;
    frameLabel.size.height = labelSize.height;
    frameLabel.origin.y = CGRectGetMaxY(_imageScrollView.frame) + 13.0;
    _commentLabel.frame = frameLabel;
}

#pragma mark - 加载数据
/// 获取商品评价所有数据
- (void)loadJsonData {
    
    //  从json中获取商品结果数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"CommentsDetail" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.commentsDetailData = [CommentsDetail mj_objectArrayWithKeyValuesArray:jsonDic];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.commentsDetailData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"commentsIdentifier";
    ZRCommentsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZRCommentsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.commentsDetail = [self.commentsDetailData objectAtIndex:indexPath.row];
    if (cell.commentsDetail.images.count > 0) {
        CommentsDetail *commentsDetail = cell.commentsDetail;
        cell.showWholeImageView = ^(NSInteger index){
            [self showWholeImageViewWithImages:commentsDetail atIndex:index];
        };
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = 0.0;
    height += 32.0;
    
    CommentsDetail *commentsDetail = [self.commentsDetailData objectAtIndex:indexPath.row];
    //  计算Label的高度
    CGSize size = CGSizeMake(SCREEN_WIDTH - 6.0 * 2, 1000);
    CGSize labelSize = [commentsDetail.content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    height += labelSize.height;
    
    //  计算图片的高度
    if (commentsDetail.images && [commentsDetail.images count] > 0) {
        //  图片边距
        CGFloat edgeInset = (SCREEN_WIDTH - 100.0 * 3)/4;
        
        NSInteger row = 0;
        if (commentsDetail.images.count % 3 == 0) {
            row = commentsDetail.images.count/3;
        }else {
            row = commentsDetail.images.count/3 + 1;
        }
        CGFloat heightForImageView = row * (100.0 + edgeInset) + 11.0;
        height += heightForImageView;
    }
    
    return height;
}

#pragma mark - UIScrollViewDelegate
/// 根据scrollView的横向偏移量，更改标题的当前图片页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == _imageScrollView) {
        //  计算当前图片页码
        CGFloat xOffset = scrollView.contentOffset.x;
        NSInteger index = (xOffset + SCREEN_WIDTH/2)/SCREEN_WIDTH + 1;
        
        //  获取当前标题的内容
        NSString *text = _titleLabel.text;
        //  拆分string
        NSArray *array = [text componentsSeparatedByString:@" "];
        //  更改标题第一个位置的内容
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
        [mutableArray setObject:[NSString stringWithFormat:@"%ld",index] atIndexedSubscript:0];
        //  合并string
        text = @"";
        for (NSInteger i = 0; i < mutableArray.count; i++) {
            if (i == 0) {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"%@",[mutableArray objectAtIndex:i]]];
            }else {
                text = [text stringByAppendingString:[NSString stringWithFormat:@" %@",[mutableArray objectAtIndex:i]]];
            }
        }
        _titleLabel.text = text;
    }
}
@end
