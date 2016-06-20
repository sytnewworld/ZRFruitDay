//
//  ZRHomeViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  首页
//

#import "ZRHomeViewController.h"
#import "ZRWebViewDetailViewController.h"
#import "ZRHomeCollectionViewCell.h"
#import "ZRHomeTableViewCell.h"
#import "Home.h"

static NSString *cellIdentifier = @"ZRHomeCollectionViewCell";

@interface ZRHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) Home *home;
@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *rotationImageArray;   //  轮播图图片数据
@property (nonatomic, strong) NSMutableArray *fourInOneArray;       //  四合一图片组合

@property (nonatomic, assign) BOOL isDragging;                      //  是否在拖动
@property (nonatomic, strong) NSTimer *timer;                       //  设置定时器
@property (nonatomic, assign) NSInteger currentNum;                 //  当前图片位置
@property (nonatomic, assign) NSInteger totalNum;                   //  图片总数

@property (nonatomic, strong) UIImageView *leftImageView;           //  左视图
@property (nonatomic, strong) UIImageView *rightImageView;          //  右视图
@property (nonatomic, strong) UILabel *pageNumLabel;                //  当前图片位置显示


@end

@implementation ZRHomeViewController

#pragma mark - Life Cycle
- (instancetype)init {

    if (self = [super init]) {
        self.rotationImageArray = [NSMutableArray array];
        self.fourInOneArray = [NSMutableArray array];
        _isDragging = NO;
        //  当前显示图片位置
        _currentNum = 0;
        _totalNum = 5;
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self buildTableView];
    [self buildTableHeaderView];
//    [self buildCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.headerScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0.0) animated:NO];
    [self loadHomeData];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    //  设置时钟动画
    self.timer = [NSTimer timerWithTimeInterval:2.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    //  停止时钟
    [self.timer invalidate];
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
}

#pragma mark - Custom View
///  初始化tableview
- (void)buildTableView {

    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - PHONE_TABBAR_HEIGHT) style:UITableViewStylePlain];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.backgroundColor = COLOR_BACKGROUND;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_homeTableView];
}

///  初始化tableView的tableHeaderView
- (void)buildTableHeaderView {

    CGFloat height = 115.0;
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, height + 145.0)];
//    tableHeaderView.backgroundColor = [UIColor clearColor];
    _homeTableView.tableHeaderView = tableHeaderView;
    
    self.headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, height)];
    _headerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (_totalNum + 2), height);
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.pagingEnabled = YES;
    _headerScrollView.delegate = self;
    
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, height)];
    [_headerScrollView addSubview:_leftImageView];
    
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (_totalNum + 1), 0.0, SCREEN_WIDTH, height)];
    [_headerScrollView addSubview:_rightImageView];
    
    // 轮播图上添加点击手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_headerScrollView addGestureRecognizer:tapGestureRecognizer];
    [tableHeaderView addSubview:_headerScrollView];
    
    self.pageNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(250.0, 90.0, 20.0, 15.0)];
    self.pageNumLabel.textColor = [UIColor purpleColor];
    self.pageNumLabel.font = [UIFont systemFontOfSize:14.0];
    self.pageNumLabel.text = @"1";
    [tableHeaderView addSubview:_pageNumLabel];
}

/// 初始化collectionView
- (void)buildCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //  垂直滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    //  注册cell
    [self.collectionView registerClass:[ZRHomeCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}

#pragma mark - Private Methods
///  从JsonDic获取首页数据
- (void)loadHomeData {
    
    //  从json中获取首页数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"Home" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.home = [Home mj_objectWithKeyValues:jsonDic];
//    [self.collectionView reloadData];
    // 轮播图数据
    NSInteger i = 0;
    for (BaseModel *base in self.home.rotation) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * (i+1), 0.0, SCREEN_WIDTH, 115.0)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:base.photo]];
        [_headerScrollView addSubview:imageView];
        [self.rotationImageArray addObject:imageView];
        i++;
    }
    
    BaseModel *leftBase = [self.home.rotation objectAtIndex:i-1];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftBase.photo]];
    
    BaseModel *rightBase = [self.home.rotation objectAtIndex:0];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightBase.photo]];
}

#pragma mark - Actions
/// 处理轮播图上的点击事件
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {

    //  计算当前scrollview的页码,上取整 double ceil(double);下取整 double floor(double)
    CGFloat xOffset = _headerScrollView.contentOffset.x - SCREEN_WIDTH;
    _currentNum = xOffset / SCREEN_WIDTH;
    BaseModel *base = [self.home.rotation objectAtIndex:_currentNum];
    ZRWebViewDetailViewController *webViewDetailViewController = [[ZRWebViewDetailViewController alloc] initWithLinkURL:base.page_url];
    [self.navigationController pushViewController:webViewDetailViewController animated:YES];
}

/// 时钟更新
- (void)update:(NSTimer *)timer {

//    NSLog(@"%f",self.headerScrollView.contentOffset.x);
    if (_isDragging) {
        return;
    }
    
    CGPoint offset = self.headerScrollView.contentOffset;
    offset.x += SCREEN_WIDTH;
    [self.headerScrollView setContentOffset:offset animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger totalNum = 1;
    if (section == 0) {
        totalNum = self.home.top_banner.count;
    }else if (section == 1) {
        totalNum = self.home.horizontal_product_banner.count/3;
    }else if (section == 2) {
        totalNum = self.home.fourInOne_banner.count/4;
    }else if (section == 3) {
        totalNum = self.home.banner.count;
    }
    return totalNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellSingleIdentifier = @"cellSingleIdentifier";
    static NSString *cellThreeInOneIdentifier = @"cellThreeInOneIdentifier";
    static NSString *cellFourInOneIdentifier = @"cellFourInOneIdentifier";
    
    ZRHomeTableViewCell *cell = nil;
    NSMutableArray *array = [NSMutableArray array];

    //  三合一分区
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellThreeInOneIdentifier];
        if (!cell) {
            cell = [[ZRHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellThreeInOneIdentifier];
        }
        for (BaseModel *base in self.home.horizontal_product_banner) {
            [array addObject:base];
        }
        cell.baseModelArray = array;
        cell.cellType = ZRHomeCellTypeThreeInOne;
    }else if (indexPath.section == 2) {
    //  四合一分区
        cell = [tableView dequeueReusableCellWithIdentifier:cellFourInOneIdentifier];
        if (!cell) {
            cell = [[ZRHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFourInOneIdentifier];
        }
        for (NSInteger i = 0; i < 4; i++) {
            [array addObject:[self.home.fourInOne_banner objectAtIndex:(indexPath.row * 4 + i)]];
        }
        cell.baseModelArray = array;
        cell.cellType = ZRHomeCellTypeFourInOne;
    }else {
    //  单个图片分区
        cell = [tableView dequeueReusableCellWithIdentifier:cellSingleIdentifier];
        if (!cell) {
            cell = [[ZRHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSingleIdentifier];
        }
        if (indexPath.section == 0) {
            [array addObject:[self.home.top_banner objectAtIndex:indexPath.row]];
            cell.baseModelArray = array;
        }else if (indexPath.section == 3) {
            [array addObject:[self.home.banner objectAtIndex:indexPath.row]];
            cell.baseModelArray = array;
        }
        cell.cellType = ZRHomeCellTypeSingle;
    }
    cell.clickCell = ^(NSString *page_url){
        ZRWebViewDetailViewController *webViewDetailViewController = [[ZRWebViewDetailViewController alloc] initWithLinkURL:page_url];
        [self.navigationController pushViewController:webViewDetailViewController animated:YES];
    };
//    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = 0.0;
    if (indexPath.section == 1) {
        height = 150.0 + 11.0;
    }else if (indexPath.section == 2) {
        height = 100.0 + 170.0 + 2.0 + 11.0;
    }else {
        height = 115.0 + 11.0;
    }
    return height;
}

//  cell显示动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    cell.alpha = 0.5;
    CGAffineTransform transformScale = CGAffineTransformMakeScale(0.3, 0.8);
    CGAffineTransform transformTranslate = CGAffineTransformMakeTranslation(0.5, 0.6);
    cell.transform = CGAffineTransformConcat(transformScale, transformTranslate);
    [tableView bringSubviewToFront:cell.contentView];
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.alpha = 1;
        //  清空  transform
        cell.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.headerScrollView) {
        //  轮播图数量
        CGFloat xOffset = scrollView.contentOffset.x;
        _currentNum = (NSInteger)(xOffset - SCREEN_WIDTH/2)/SCREEN_WIDTH;
        if (_currentNum > (_totalNum - 1) || _currentNum < 1) {
            _pageNumLabel.text = @"1";
        }else {
            _pageNumLabel.text = [NSString stringWithFormat:@"%ld",_currentNum + 1];
        }
        
        if (xOffset <= 0) {
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * _totalNum, 0.0) animated:NO];
        }
        if (xOffset >= SCREEN_WIDTH * (_totalNum + 1)) {
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0.0) animated:NO];
        }
    }
}

//  开始滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    if (scrollView == self.homeTableView) {
        
    }else if (scrollView == self.headerScrollView) {
        _isDragging = YES;
    }
}

//  停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView == self.homeTableView) {
        
    }else if (scrollView == self.headerScrollView) {
        _isDragging = NO;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 4 + self.home.fourInOne_banner.count/4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSInteger totalNum = 1;
    if (section == 0) {
        totalNum = 1;
    }else if (section == 1) {
        totalNum = self.home.top_banner.count;
    }else if (section == 2) {
        totalNum = self.home.horizontal_product_banner.count;
    }else if (section == 3 || section == 4 || section == 5) {
        totalNum = 4;
    }else {
        totalNum = self.home.banner.count;
    }
    return totalNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZRHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    if (indexPath.section == 1) {
        cell.baseModel = [self.home.top_banner objectAtIndex:indexPath.row];
    }else if (indexPath.section == 2) {
        cell.baseModel = [self.home.horizontal_product_banner objectAtIndex:indexPath.row];
    }else if (indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5) {
        cell.baseModel = [self.home.fourInOne_banner objectAtIndex:(indexPath.section - 3) * 4 + indexPath.row];
    }else {
        cell.baseModel = [self.home.banner objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize size;
    CGFloat width = SCREEN_WIDTH - 6.0 * 2;
    if (indexPath.section == 0) {
        size = CGSizeMake(width, 115.0 + 145.0);
    }else if (indexPath.section == 1) {
        size = CGSizeMake(width, 115.0);
    }else if (indexPath.section == 2) {
        size = CGSizeMake((width - 2.0 * 2)/3, 150.0);
    }else if (indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5) {
        if (indexPath.row == 0) {
            size = CGSizeMake(width, 100.0);
        }else if (indexPath.row == 1) {
            size = CGSizeMake(125.0, 170.0);
        }else {
            size = CGSizeMake(183.0, 84.0);
        }
    }else {
        size = CGSizeMake(width, 115.0);
    }
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

        return UIEdgeInsetsMake(11.0, 6.0, 11.0, 6.0);
}

@end
