//
//  ZRFruitEatViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  果食
//

#import "ZRFruitEatViewController.h"
#import "ZRRichScanViewController.h"
#import "ZRFruitEatTableViewCell.h"
#import "FruitEat.h"
#import "ZRFruitEatTopButton.h"
#import "ZRTopButtonModel.h"

#import "ZRFruitEatTableHeaderView.h"

@interface ZRFruitEatViewController ()<UITableViewDataSource, UITableViewDelegate>

/// 顶部六个标题按钮的数据
@property (nonatomic, strong) NSMutableArray *topButtonData;
/// 果食所有内容
@property (nonatomic, strong) FruitEat *fruitEatData;
/// 最新发布的所有内容
@property (nonatomic, strong) NSMutableArray *releaseContentData;

/// 果食页面 主体TableView
@property (nonatomic, strong) UITableView *tableView;
/// 表视图的顶部TableHeaderView
@property (nonatomic, strong) ZRFruitEatTableHeaderView *tableHeaderView;

@end

@implementation ZRFruitEatViewController

#pragma mark - Life Cycle
- (instancetype)init {

    if (self = [super init]) {
        _topButtonData = [NSMutableArray array];
        _releaseContentData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //  导入数据
    [self loadJSONDataForTopButton];
    [self loadJSONDataForReleaseContent];
    //  初始化视图
    [self buildNavigationView];
    [self buildTableView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [_tableHeaderView changeScrollViewContentOffset];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [_tableHeaderView timerStart];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [_tableHeaderView timerStop];
}

#pragma mark - Build View
/// 导航栏
- (void)buildNavigationView {

    self.title = @"果食";
    
    // 左侧按钮
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Personal"] style:UIBarButtonItemStylePlain target:self action:@selector(showPersonalInformation)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    // 右侧按钮
    UIBarButtonItem *informationCenterItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Information"] style:UIBarButtonItemStylePlain target:self action:@selector(showInformationCenter)];
    UIBarButtonItem *richScanItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"RichScan"] style:UIBarButtonItemStylePlain target:self action:@selector(handleRichScan)];
    self.navigationItem.rightBarButtonItems = @[richScanItem, informationCenterItem];
}

/// 主体Body为TableView:TableHeaderView和cell内容
- (void)buildTableView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - PHONE_TABBAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:_tableView];
    
    self.tableHeaderView = [ZRFruitEatTableHeaderView fruitEatTableHeaderViewWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 45.0 + 115.0 + 190.0) TopButtonData:_topButtonData fruitEatData:_fruitEatData];
    _tableHeaderView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _tableHeaderView;
}

/// 最新发布内容
- (void)buildReleaseContentView {

    
}

#pragma mark - 加载JSON数据
///获取顶部标题按钮
- (void)loadJSONDataForTopButton {

    NSDictionary *jsonDic = [self openFileForSource:@"TopButton"];
    self.topButtonData = [ButtonBase mj_objectArrayWithKeyValuesArray:jsonDic];
}

/// 获取最新发布内容数据
- (void)loadJSONDataForReleaseContent {

    NSDictionary *jsonDic = [self openFileForSource:@"LastestContent"];
    self.fruitEatData = [FruitEat mj_objectWithKeyValues:jsonDic];
    self.releaseContentData = [_fruitEatData.main copy];
}

#pragma mark - Private Methods
/// 打开文件并获取数据
- (NSDictionary *)openFileForSource:(NSString *)name {

    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    return jsonDic;
}

#pragma mark - Actions
/// 个人中心
- (void)showPersonalInformation {

    
}

/// 消息中心
- (void)showInformationCenter {

    
}

/// 扫一扫
- (void)handleRichScan {

    NSLog(@"扫描二维码/条形码");
    ZRRichScanViewController *richScanViewController = [[ZRRichScanViewController alloc] init];
    [self.navigationController pushViewController:richScanViewController animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _releaseContentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZRFruitEatTableViewCell *cell = [ZRFruitEatTableViewCell cellWithTableView:tableView model:[self.fruitEatData.main objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CGFloat height = 39.0;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, height)];
    
    //  最新发布图标
    UIImageView *iconNewRelease = [[UIImageView alloc] initWithFrame:CGRectMake(11.0, (height - 20.0)/2, 20.0, 20.0)];
    [iconNewRelease setImage:[UIImage imageNamed:@"NewRelease"]];
    [headerView addSubview:iconNewRelease];
    
    //  最新发布标题
    UILabel *newReleaseTitle = [[UILabel alloc] initWithFrame:CGRectMake(34.0, 0.0, 100.0, height)];
    newReleaseTitle.text = @"最新发布";
    newReleaseTitle.textColor = COLOR_TITLE;
    newReleaseTitle.font = [UIFont boldSystemFontOfSize:15.0];
    [headerView addSubview:newReleaseTitle];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 39.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 110.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UIScrollViewDelegate
//  滚动过程中每像素调用一次方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.tableView) {
        //  取消TableView HeaderView黏性
        CGFloat sectionHeaderHeight = 39.0;
        CGFloat yOffset = scrollView.contentOffset.y + PHONE_STATUSBAR_HEIGHT + PHONE_NAVIGATIONBAR_HEIGHT;
        if (yOffset >= 0 && yOffset <= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0.0, 0.0, 0.0);
        }else if (yOffset > sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(- sectionHeaderHeight + PHONE_STATUSBAR_HEIGHT + PHONE_NAVIGATIONBAR_HEIGHT, 0.0, 0.0, 0.0);
        }
    }
}

@end

