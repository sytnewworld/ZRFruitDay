//
//  ZRProductDetailViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品详情页
//

#import "ZRProductDetailViewController.h"
#import "ZRWebViewDetailViewController.h"
#import "ZRCommentsDetailViewController.h"
#import "ZRProductDetailCell.h"

#import "Product.h"
#import "ProductSendRegion.h"

@interface ZRProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZRProductDetailCellDelegate,ZRCommonViewDelegate>

/// 商品数据信息
@property (nonatomic, strong) ProductDetail *productDetail;
/// 商品配送区域信息
@property (nonatomic, strong) ProductSendRegion *productSendRegion;
/// 商品评论数
@property (nonatomic, strong) ProductComments *productComments;
/// 商品页果实百科
@property (nonatomic, strong) ProductFruitEat *productFruitEat;

/// TableViewHeader容器
@property (nonatomic, strong) UIView *headerTableView;
/// 自定义导航栏
@property (nonatomic, strong) UIView *navigationBarView;

/// 商品展示TableView
@property (nonatomic, strong) UITableView *productTableView;
/// 商品图片
@property (nonatomic, strong) UIScrollView *productIconScrollView;

/// 商品名称
@property (nonatomic, strong) UILabel *productNameLabel;
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
/// 商品详情页
@property (nonatomic, strong) UIWebView *productImageDetailImageView;

/// 分页符号
@property (nonatomic, strong) UIPageControl *iconPageControl;
/// 收藏该商品
@property (nonatomic, assign) BOOL isFavorite;

/// 上拉刷新
@property (nonatomic, strong) MJRefreshBackNormalFooter *refreshFooter;
/// 下拉刷新
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;

@end

@implementation ZRProductDetailViewController {

    /// 商品数量
    NSInteger _productNum;
}

#pragma mark - Life Cycle
- (instancetype)init {

    if (self = [super init]) {
        _productNum = 0;
        _isFavorite = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildRefreshButton];
    [self buildProductTableView];
    [self buildProductIconScrollView];
    [self customNavigationBar];
    //  设置层数，使得导航栏在最上方,中间为HeaderTableView,最底下为TableView
    self.productTableView.layer.zPosition = 0;
    self.headerTableView.layer.zPosition = 1;
    self.navigationBarView.layer.zPosition = 2;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self loadJsonData];
    [self loadRegionData];
    [self loadCommentsData];
    [self loadFruitEatData];
    [self.productTableView reloadData];
}

/// TableViewCell显示完全分割线
- (void)viewDidLayoutSubviews {

    if ([self.productTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.productTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.productTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.productTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Build View
/// 自定义导航栏
- (void)customNavigationBar {
    
    self.navigationBarView = [ZRCommonView customNavigationBarWithDelegate:self];
    [self.view addSubview:_navigationBarView];
    
    //  添加喜欢
    UIButton *favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 62.0 - 36.0, 5.0, 36.0, 36.0)];
    if (_isFavorite) {
        [favoriteButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    }else {
        [favoriteButton setImage:[UIImage imageNamed:@"favorite_no"] forState:UIControlStateNormal];
    }
    [favoriteButton addTarget:self action:@selector(clickFavorite:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBarView addSubview:favoriteButton];
}

/// 初始化TableView视图
- (void)buildProductTableView {

    self.productTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _productTableView.dataSource = self;
    _productTableView.delegate = self;
    _productTableView.showsVerticalScrollIndicator = NO;
    _productTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_productTableView];
    _productTableView.contentInset = UIEdgeInsetsMake(280.0, 0.0, 0.0, 0.0);
    _productTableView.mj_footer = _refreshFooter;
}

/// 初始化上拉刷新、下拉刷新
- (void)buildRefreshButton {

    //  设置上拉刷新
    _refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadWebData)];
    [_refreshFooter setTitle:@"上拉,查看图文详情" forState:MJRefreshStateIdle];
    [_refreshFooter setTitle:@"松开,马上加载图文详情" forState:MJRefreshStatePulling];
    [_refreshFooter setTitle:@"正在加载中" forState:MJRefreshStateRefreshing];
    [_refreshFooter setTitle:@"加载完成" forState:MJRefreshStateNoMoreData];
    _refreshFooter.backgroundColor = COLOR_BACKGROUND;
    
    //  设置下拉刷新
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(backTableView)];
    _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    [_refreshHeader setTitle:@"下拉,返回商品简介" forState:MJRefreshStateIdle];
    [_refreshHeader setTitle:@"松开,返回商品简介" forState:MJRefreshStatePulling];
    [_refreshHeader setTitle:@"正在刷新中" forState:MJRefreshStateRefreshing];
    _refreshHeader.backgroundColor = COLOR_BACKGROUND;
}

/// 初始化商品图片ScrollView视图
- (void)buildProductIconScrollView {

    self.headerTableView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 280.0)];
//    _headerTableView.backgroundColor = [UIColor clearColor];
    
    self.productIconScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 280.0)];
    _productIconScrollView.backgroundColor = [UIColor purpleColor];
    _productIconScrollView.delegate = self;
    _productIconScrollView.pagingEnabled = YES;
    _productIconScrollView.showsHorizontalScrollIndicator = NO;
    [_headerTableView addSubview:_productIconScrollView];
    
    //  添加分页符号
    self.iconPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(_productIconScrollView.frame) - 40.0, SCREEN_WIDTH, 40.0)];
    [_iconPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    _iconPageControl.currentPage = 0;
    [_headerTableView addSubview:_iconPageControl];
    [self.view addSubview:_headerTableView];
}

#pragma mark - Private Methods
/// 利用分页时控制icon的变化
- (void)changePage:(UIPageControl *)pageControl {

    //  获取当前分页数
    NSInteger currentPage = pageControl.currentPage;
    //  调整当前icon显示...
    self.productIconScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * currentPage, 0);
}

/// cell的标题 ———— 统一显示:15号加租字体，黑色
- (UILabel *)customLabel {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 16.0, 15.0 * 4, 15.0)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

/// cell的初始化
- (ZRProductDetailCell *)tableView:(UITableView *)tableView buildCellWithIdentifier:(NSString *)identifier {

    ZRProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZRProductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

/// 重写父类方法，返回
- (void)barBack {
    
    [UIView animateWithDuration:.5f animations:^{
        [self.navigationController popViewControllerAnimated:NO];
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BackProductsListWithAnimation" object:self userInfo:nil];
        }
    }];
}

#pragma mark - Actions
/// 点击喜欢按钮
- (void)clickFavorite:(UIButton *)button {

    _isFavorite = !_isFavorite;
    //  旋转效果动画
    CATransform3D transform = CATransform3DMakeRotation(M_PI/2, 0.0, 1.0, 0.0);
    [UIView animateWithDuration:.3f animations:^{
        //  旋转90度
        button.imageView.layer.transform = transform;
    }completion:^(BOOL finished) {
        //  旋转90度之后，设置
        [UIView animateWithDuration:.3f animations:^{
            if (_isFavorite) {
                [button setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
            }else {
                [button setImage:[UIImage imageNamed:@"favorite_no"] forState:UIControlStateNormal];
            }
            button.imageView.transform = CGAffineTransformIdentity;
        }];
    }];
}

/// 加载商品详情页web数据
- (void)loadWebData {

    //  停止刷新
    [self.refreshFooter endRefreshing];
    if (!_productImageDetailImageView) {
        //  获取商品详情页数据
        self.productImageDetailImageView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _productImageDetailImageView.backgroundColor = COLOR_BACKGROUND;
        [_productImageDetailImageView loadHTMLString:self.productDetail.product.discription baseURL:nil];
        _productImageDetailImageView.scrollView.mj_header = _refreshHeader;
        [self.view addSubview:_productImageDetailImageView];
        [self.view bringSubviewToFront:self.navigationBarView];
    }
    //  TableView在窗口上方，当前窗口显示商品详情页
    [UIView animateWithDuration:.5f animations:^{
        _productTableView.frame = CGRectMake(0.0, - SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        _productImageDetailImageView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

/// 返回TableView
- (void)backTableView {

    [_refreshHeader endRefreshing];
    //  商品详情页位于窗口下方，当前窗口显示TableView
    [UIView animateWithDuration:.5f animations:^{
        _productImageDetailImageView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        _productTableView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    //  TableView显示位置为距离上方tableHeaderView的高度
    [_productTableView setContentOffset:CGPointMake(0.0, - 280.0) animated:YES];
}

#pragma mark - 加载数据
/// 刷新TableView数据
- (void)loadJsonData {

    //  从json中获取商品结果数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"Product" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.productDetail = [ProductDetail mj_objectWithKeyValues:jsonDic];
    [self loadScrollViewData];
}

/// 获取配送区域数据
- (void)loadRegionData {

    //  从json中获取区域数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"ProductSendRegion" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.productSendRegion = [ProductSendRegion mj_objectWithKeyValues:jsonDic];
}

/// 获取评论数
- (void)loadCommentsData {
  
    //  从json中获取评论数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"ProductComments" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.productComments = [ProductComments mj_objectWithKeyValues:jsonDic];
}

/// 获取果实百科数据
- (void)loadFruitEatData {

    //  从json中获取果实百科数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"ProductFruitEat" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.productFruitEat = [ProductFruitEat mj_objectWithKeyValues:jsonDic];
}

/// 更新商品轮播图数据
- (void)loadScrollViewData {
    
    _productIconScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.productDetail.photo.count, 280.0);
    _iconPageControl.numberOfPages = self.productDetail.photo.count;
    NSInteger index = 0;        //  当前位置
    for (RotationPhoto *rotationPhoto in self.productDetail.photo) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * index, 0.0, SCREEN_WIDTH, 280.0)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:rotationPhoto.photo]];
        [self.productIconScrollView addSubview:imageView];
        index ++;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *productInformationIdentifier = @"ProductInformationCellIdentifier";
    static NSString *productVolumeIdentifier = @"ProductVolumeCellIdentifier";
    static NSString *productSendIdentifier = @"ProductSendCellIdentifier";
    static NSString *productCommentsIdentifier = @"ProductCommentsCellIdentifier";
    static NSString *productFruitEatIdentifier = @"ProductFruitEatCellIdentifier";
    static NSString *productHotIdentifier = @"ProductHotCellIdentifier";
    
    ZRProductDetailCell *cell = nil;
    //  cell的位置————行数
    NSInteger index = indexPath.row;
    switch (index) {
        case 0: {
            cell = [self tableView:tableView buildCellWithIdentifier:productInformationIdentifier];
            cell.changeProductNumWithButton = ^(UIButton *button,NSInteger productNum){
            
                _productNum = productNum;
                /// 数量减少
                if (button.tag == 10 && productNum > 1) {
                    _productNum--;
                }
                //  数量增加
                if (button.tag == 99 && productNum < 200) {
                    _productNum++;
                }
                return _productNum;
            };
            break;
        }
        case 1: {
            cell = [self tableView:tableView buildCellWithIdentifier:productVolumeIdentifier];
            break;
        }
        case 2: {
            cell = [self tableView:tableView buildCellWithIdentifier:productSendIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.productSendMessage = self.productSendRegion.msg;
            break;
        }
        case 3: {
            cell = [self tableView:tableView buildCellWithIdentifier:productCommentsIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.productComments = self.productComments;
            break;
        }
        case 4: {
            cell = [self tableView:tableView buildCellWithIdentifier:productFruitEatIdentifier];
            cell.productFruitEat = self.productFruitEat;
            break;
        }
        case 5: {
            cell = [self tableView:tableView buildCellWithIdentifier:productHotIdentifier];
            cell.delegate = self;
            break;
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.productDetail = self.productDetail;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = 0.0;
    if (indexPath.row == 0) {
        height = 111;
    }else if (indexPath.row == 1) {
        height = 45.0;
    }else if (indexPath.row == 2) {
        height = 68.0;
    }else if (indexPath.row == 3) {
        height = 43.0;
    }else if (indexPath.row == 4) {
        height = 116.0;
    }else if (indexPath.row == 5) {
        height = 166.0;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 第三行为商品评价页
    if (indexPath.row == 3) {
        ZRCommentsDetailViewController *commentsDetailViewController = [[ZRCommentsDetailViewController alloc] init];
        //  UIViewController转场动画
        commentsDetailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:commentsDetailViewController animated:YES completion:nil];
    }
}

/// TableViewCell显示完全分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    COLOR_SPECIAL;
}

#pragma mark - UIProductDetailCellDelegate
/// 展示WebView详情页
- (void)showWebViewDetailWithPageURL:(NSString *)pageURL {

    ZRWebViewDetailViewController *webViewDetailViewController = [[ZRWebViewDetailViewController alloc] initWithLinkURL:pageURL];
    [self.navigationController pushViewController:webViewDetailViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate
/// 滑动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    //  控制scrollview的分页
    if (scrollView == _productIconScrollView) {
        CGFloat xOffset = scrollView.contentOffset.x;
        NSInteger index = (xOffset - SCREEN_WIDTH/2)/SCREEN_WIDTH + 1;
        self.iconPageControl.currentPage = index;
    }
    //  向上滑动，scrollview也向上滑动，向下滑动，放大scrollview
    if (scrollView == _productTableView) {
        CGFloat yOffset = scrollView.contentOffset.y + 280.0;
        if (yOffset > 0) {
            //  设置层数，使得导航栏在最上方,中间为HeaderTableView,最底下为TableView
            self.headerTableView.layer.zPosition = 0;
            self.productTableView.layer.zPosition = 1;
            //  HeaderTableView随TableView的滚动而滚动，速度减半
            CGRect frame = self.headerTableView.frame;
            frame.origin.y = - yOffset/2;
            self.headerTableView.frame = frame;
            //  当商品详情页请求之后，随着TableView的滚动而滚动
            if (_productImageDetailImageView && yOffset >= 300.0) {
                CGRect frame = self.productImageDetailImageView.frame;
                frame.origin.y = SCREEN_HEIGHT - yOffset + 300.0;
                self.productImageDetailImageView.frame = frame;
            }
        }else if (yOffset <= 0) {
            self.productTableView.layer.zPosition = 0;
            self.headerTableView.layer.zPosition = 1;
            //  向下滑动
            _productIconScrollView.center = CGPointMake(SCREEN_WIDTH/2, (280.0 - yOffset)/2);
            _productIconScrollView.transform = CGAffineTransformMakeScale(1 - yOffset/280.0, 1 - yOffset/280.0);
            _iconPageControl.frame = CGRectMake(0.0, CGRectGetHeight(_productIconScrollView.frame) - 40.0, SCREEN_WIDTH, 40.0);
        }
    }
}

@end
