//
//  ZRSubClassifyDetailViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/25.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  二级分类搜索商品结果页
//

#import "ZRSubClassifyDetailViewController.h"
#import "ZRProductDetailViewController.h"
#import "ZRProductListTableViewCell.h"
#import "Product.h"

@interface ZRSubClassifyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

/// 不同筛选条件 ——————  新品、热卖、价格
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
/// 商品显示视图
@property (nonatomic, strong) UITableView *productListTableView;
//  商品列表数据
@property (nonatomic, strong) NSMutableArray *productsListArray;

/// 获取当前选中的cell中的图片
@property (nonatomic, strong) UIImageView *imageViewInCell;

@end

@implementation ZRSubClassifyDetailViewController {
    
    /// 当前window
    UIWindow *_window;
    /// 当前选中cell的位置信息
    NSIndexPath *_indexPathForImageViewInCell;
    /// 记录选中cell时ImageView的在cell中的frame
    CGRect _frameForImageViewInCell;
    /// 记录ImageView相对window的绝对frame
    CGRect _frameForImageViewInWindow;
    /// 水平方向移动的距离
    CGFloat _xOffset;
    /// 垂直方向移动的距离
    CGFloat _yOffset;
    // 计数器
    NSInteger _num;
}

#pragma mark - Life Cycle
- (instancetype)init {

    if (self = [super init]) {
        _num = 0;
        _productsListArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = nil;
    [self buildSegmentControl];
    [self buildTableView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(backWithAnimation:) name:@"BackProductsListWithAnimation" object:nil];
    
    [self loadJsonData];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    // 移除监听通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Build View
/// 初始化分段控件
- (void)buildSegmentControl {

    NSArray *array = [NSArray arrayWithObjects:@"新品",@"热卖",@"价格", nil];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
//    _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    _segmentedControl.frame = CGRectMake(6.0, 6.0 + PHONE_NAVIGATIONBAR_HEIGHT + PHONE_STATUSBAR_HEIGHT, SCREEN_WIDTH - 6.0 * 2, 28.0);
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = COLOR_HIGHLIGHT_TITLE;
    _segmentedControl.layer.borderColor = COLOR_HIGHLIGHT_TITLE.CGColor;
    //  点击后是否恢复原样
    _segmentedControl.momentary = NO;
    [_segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [_segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_TITLE,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [_segmentedControl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
}

/// 商品列表显示视图
- (void)buildTableView {

    self.productListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_segmentedControl.frame) + 6.0, SCREEN_WIDTH, VIEW_HIDETABBAR_HEIGHT - 6.0 - 28.0) style:UITableViewStylePlain];
    _productListTableView.backgroundColor = [UIColor purpleColor];
    _productListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _productListTableView.dataSource = self;
    _productListTableView.delegate = self;
    [self.view addSubview:_productListTableView];
}

#pragma mark - Private Methods
/// 分段控件不同位置的切换
- (void)segmentedAction:(UISegmentedControl *)segmentControl {

    NSInteger index = segmentControl.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self selectNewProductList];
            break;
        case 1:
            [self selectHotProductList];
            break;
        case 2:
            [self selectPriceProductList];
            break;
        default:
            break;
    }
}

/// 选择新品
- (void)selectNewProductList {

    NSLog(@"%s",__func__);
}

/// 选择热卖商品
- (void)selectHotProductList {

    NSLog(@"%s",__func__);
}

/// 选择价格
- (void)selectPriceProductList {

    NSLog(@"%s",__func__);
}

#pragma mark - Actions
- (void)backWithAnimation:(NSNotificationCenter *)notification {

    ZRProductListTableViewCell *cell = [self.productListTableView cellForRowAtIndexPath:_indexPathForImageViewInCell];

    //  获取当前app的window
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *window = [windows objectAtIndex:0];
    _imageViewInCell.alpha = 1.0;
    [window addSubview:_imageViewInCell];

    //  缩放变换
//    CGAffineTransform transformScale = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:.5f animations:^{
//        _imageViewInCell.transform = transformScale;
        //  恢复形变(缩放),上下两行方法效果相同
        _imageViewInCell.transform = CGAffineTransformIdentity;
        NSLog(@"%@",NSStringFromCGRect(_imageViewInCell.frame));
    }completion:^(BOOL finished) {
        if (finished) {
            _imageViewInCell.frame = _frameForImageViewInCell;
            [cell.contentView addSubview:_imageViewInCell];
        }
    }];
}

#pragma mark - 加载数据
- (void)loadJsonData {

    //  从json中获取二级分类搜索结果数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"ProductsList" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.productsListArray = [ProductsList mj_objectArrayWithKeyValuesArray:jsonDic];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.productsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"ProductListIdentifier";
    ZRProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZRProductListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.productsList = [self.productsListArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 121.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ZRProductListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    /**
     *  找到当前cell显示商品图片的ImageView，将其添加至Windows上，移动其至最上方位置，并缩放至商品详情页所显示的商品图片大小
     */
    //   记录当前选中的cell的位置
    _indexPathForImageViewInCell = indexPath;
    
    //  找到当前cell中的ImageView
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            self.imageViewInCell = (UIImageView *)view;
        }
    }
    //  记录当前选中cell的ImageView的frame
    _frameForImageViewInCell = _imageViewInCell.frame;
    //  获取当前app的window
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *window = [windows objectAtIndex:0];
    //  计算商品图片所在位置相距window边界的实际距离
    CGFloat originX = _imageViewInCell.frame.origin.x + cell.frame.origin.x + tableView.frame.origin.x - tableView.contentOffset.x;
    CGFloat originY = _imageViewInCell.frame.origin.y + cell.frame.origin.y + tableView.frame.origin.y - tableView.contentOffset.y;
    //  设置ImageView的frame,将其添加至当前window
    _imageViewInCell.frame = CGRectMake(originX, originY, _imageViewInCell.bounds.size.width, _imageViewInCell.bounds.size.height);
    _frameForImageViewInWindow = _imageViewInCell.frame;
    [window addSubview:_imageViewInCell];
    
    //  计算需要移动的距离
    _xOffset = SCREEN_WIDTH/2 - _imageViewInCell.center.x;
    _yOffset = 280.0/2 - _imageViewInCell.center.y;
    //  平移变换
    CGAffineTransform transformTranslation = CGAffineTransformMakeTranslation(_xOffset, _yOffset);
    //  缩放变换
    CGAffineTransform transformScale = CGAffineTransformMakeScale(SCREEN_WIDTH/100, 280.0/100.0);
    //  先平移,后缩放:根据矩阵相乘来完成这些变换的，所以从右向左开始变换
    CGAffineTransform transform = CGAffineTransformConcat(transformScale, transformTranslation);
    
    [UIView animateWithDuration:.3f animations:^{
        _imageViewInCell.transform = transform;
    } completion:^(BOOL finished) {
        //  显示商品详情页界面
        ZRProductDetailViewController *productDetailViewController = [[ZRProductDetailViewController alloc] init];
//        [self presentViewController:productDetailViewController animated:NO completion:^{
//            //  隐藏imageView
//            [window sendSubviewToBack:_imageViewInCell];
//        }];
        [self.navigationController pushViewController:productDetailViewController animated:NO];
        //  隐藏imageView
        _imageViewInCell.alpha = 0.0;
        [window sendSubviewToBack:_imageViewInCell];
    }];
}

@end
