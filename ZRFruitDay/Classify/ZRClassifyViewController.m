//
//  ZRClassifyViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/15.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//

#import "ZRClassifyViewController.h"
#import "ZRClassifyCollectionViewCell.h"
#import "ZRSubClassifyDetailViewController.h"
#import "Classify.h"

#define HEIGHT_TABLEVIEWCELL    50.0
#define WIDTH_TABLEVIEWCELL     80.0

static NSString *classifyCollectionViewCellIdentifier = @"ClassifyCollectionViewCell";

@interface ZRClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) Classify *classify;                       //  分类数据内容
@property (nonatomic, strong) UITableView *classifyTableView;           //  一级分类表视图
@property (nonatomic, strong) UICollectionView *classifyCollectionView; //  二级分类宫格图

@property (nonatomic, assign) NSInteger currentIndex;                   //  一级分类当前位置

@end

@implementation ZRClassifyViewController

#pragma mark - Life Cycle
- (instancetype)init {

    if (self = [super init]) {
        //  当前一级分类位置为第一个
        _currentIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"品类";
    [self buildTableView];
    [self buildCollectionView];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.classifyTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self loadClassifyData];
}

#pragma mark - BuildView 
/// 初始化TableView
- (void)buildTableView {
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, SCREEN_HEIGHT)];
    backgroundView.backgroundColor = COLOR_BACKGROUND;
    UIView *rightLine = [ZRCommonView generateSeperatorLineWithOriginX:80.0 - .5 originY:0.0 width:SCREEN_HEIGHT direction:1];
    rightLine.backgroundColor = COLOR_SEPERATOR_LINE;
    [backgroundView addSubview:rightLine];
    [self.view addSubview:backgroundView];

    self.classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, PHONE_STATUSBAR_HEIGHT + PHONE_NAVIGATIONBAR_HEIGHT, 80.0, SCREEN_HEIGHT - PHONE_TABBAR_HEIGHT) style:UITableViewStylePlain];
    _classifyTableView.backgroundColor = [UIColor clearColor];
    _classifyTableView.delegate = self;
    _classifyTableView.dataSource = self;
    _classifyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_classifyTableView];
}

/// 初始化CollectionView
- (void)buildCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //  垂直方向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //  最小间距
    flowLayout.minimumInteritemSpacing = 1.0;
    
    self.classifyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_classifyTableView.frame), PHONE_STATUSBAR_HEIGHT + PHONE_NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH - CGRectGetWidth(_classifyTableView.frame), VIEW_HEIGHT) collectionViewLayout:flowLayout];
    _classifyCollectionView.backgroundColor = [UIColor whiteColor];
    _classifyCollectionView.dataSource = self;
    _classifyCollectionView.delegate = self;
    [self.view addSubview:_classifyCollectionView];
    
    //  注册CollectionViewCell
    [self.classifyCollectionView registerClass:[ZRClassifyCollectionViewCell class] forCellWithReuseIdentifier:classifyCollectionViewCellIdentifier];
}

#pragma mark - Private Methods
///  从JsonDic获取分类数据
- (void)loadClassifyData {
    
    //  从json中获取分类数据
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"Classify" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.classify = [Classify mj_objectWithKeyValues:jsonDic];
    
}

/// 选中cell时的背景视图
- (UIView *)generatorSelectedBackgroundViewWithFrame:(CGRect)frame {

    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    //  TableViewCell的宽度
    CGFloat width = 80.0;
    
    UIView *topLine = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY:0.0 width:width direction:0];
    [view addSubview:topLine];
    
    UIView *bottomLine = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY:HEIGHT_TABLEVIEWCELL + .5 width:width direction:0];
    [view addSubview:bottomLine];
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.classify.common.count;
}

//  TableViewCell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *classifyTableViewCellIdentifier = @"ClassifyTableViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classifyTableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classifyTableViewCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];

        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.highlightedTextColor = COLOR_HIGHLIGHT_TITLE;
        cell.textLabel.textColor = [UIColor blackColor];
        
        //  选中cell时背景
        UIView *selectedBackgroundView = [self generatorSelectedBackgroundViewWithFrame:cell.bounds];
        cell.selectedBackgroundView = selectedBackgroundView;

        //  下分割线和右分割线
        UIView *bottomLine = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY:HEIGHT_TABLEVIEWCELL width:WIDTH_TABLEVIEWCELL direction:0];
        [cell addSubview:bottomLine];
    }
    FirstClassify *firstClassify = [self.classify.common objectAtIndex:indexPath.row];
    cell.textLabel.text = firstClassify.name;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    _currentIndex = indexPath.row;
    [self.classifyCollectionView reloadData];
}

//  TableViewCell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return HEIGHT_TABLEVIEWCELL;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

//  Item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    FirstClassify *firstClassify = [self.classify.common objectAtIndex:_currentIndex];
    return firstClassify.sub_level.count;
}

//  Item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ZRClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classifyCollectionViewCellIdentifier forIndexPath:indexPath];
    //  更新collectionView数据
    FirstClassify *firstClassify = [self.classify.common objectAtIndex:_currentIndex];
    NSMutableArray *subClassifyArray = firstClassify.sub_level;
    cell.subClassify = [subClassifyArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    ZRSubClassifyDetailViewController *subClassifyDetailViewController = [[ZRSubClassifyDetailViewController alloc] init];

    //  获取当前Item的数据
    FirstClassify *firstClassify = [self.classify.common objectAtIndex:_currentIndex];
    NSMutableArray *subClassifyArray = firstClassify.sub_level;
    SubClassify *subClassify = [subClassifyArray objectAtIndex:indexPath.row];
    
    subClassifyDetailViewController.title = subClassify.name;
    [self.navigationController pushViewController:subClassifyDetailViewController animated:YES];
}

//  Item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    //  每个Item的高度为84.0;宽度为75.0
    return CGSizeMake(75.0, 84.0);
}

//  Item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    //  垂直方向edge为8;水平方向iphone5S为8,其他需要计算
    CGFloat horitalEdgeInset = (SCREEN_WIDTH - CGRectGetWidth(self.classifyTableView.frame) - 75.0 * 3)/4;
    return UIEdgeInsetsMake(8.0, horitalEdgeInset, 8.0, horitalEdgeInset);
}
@end
