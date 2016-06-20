//
//  ZRSettingViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/26.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  设置
//

#import "ZRSettingViewController.h"

typedef NS_ENUM(NSInteger, ZRAlertViewType) {

    ZRAlertViewTypeOneButton = 0,
    ZRAlertViewTypeTwoButton
};

@interface ZRSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

/// 设置内容展示
@property (nonatomic, strong) UITableView *tableView;
/// TableView标题内容
@property (nonatomic, strong) NSArray *tableViewTitleArray;

@end

@implementation ZRSettingViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = COLOR_BACKGROUND;
    [self buildTableView];
    [self buildLogoutView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - Build View
/// 创建TableView
- (void)buildTableView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - PHONE_TABBAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    UIView *tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, PHONE_STATUSBAR_HEIGHT)];
    _tableView.tableFooterView = tableFootView;
    
    self.tableViewTitleArray = @[@[@"联系客服" ], @[@"修改密码", @"清楚图片缓存", @"个人信息"], @[@"版本信息", @"亲，给果园好评吧", @"分享APP"], @[@"关于我们", @"48小时退换货", @"常见问题", @"企业合作", @"配送说明", @"线下门店"]];
}

/// 创建退出登录容器
- (void)buildLogoutView {

    UIView *logoutView = [[UIView alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - PHONE_TABBAR_HEIGHT, SCREEN_WIDTH, PHONE_TABBAR_HEIGHT)];
    logoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logoutView];
    
    UIView *lineView = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY:0.0 width:SCREEN_WIDTH direction:0];
    [logoutView addSubview:lineView];
    
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 145.0)/2, (PHONE_TABBAR_HEIGHT - 30.0)/2, 145.0, 30.0)];
    logoutButton.backgroundColor = COLOR_SPECIAL;
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutButton.layer.cornerRadius = 15.0;
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(clickLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
    [logoutView addSubview:logoutButton];
}

/// 在特定cell上添加Label显示一些内容
- (void)tableViewCell:(UITableViewCell *)cell buildCellViewWithLabelForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (UIView *subView in cell.contentView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        UILabel *phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110.0 - 15.0, 0.0, 110.0, 43.0)];
        //        phoneNumber.text = @"400-720-0770";
        phoneNumber.text = @"18301290169";
        phoneNumber.font = [UIFont systemFontOfSize:12.0];
        phoneNumber.textAlignment = NSTextAlignmentRight;
        phoneNumber.textColor = COLOR_TITLE;
        [cell.contentView addSubview:phoneNumber];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        UILabel *versionNumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 36.0 - 15.0, 0.0, 36.0, 43.0)];
        versionNumber.text = @"3.3.0";
        versionNumber.textColor = [UIColor blackColor];
        versionNumber.font = [UIFont systemFontOfSize:12.0];
        versionNumber.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:versionNumber];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

/// 为cell添加分割线
- (void)tableViewCell:(UITableViewCell *)cell buildCellViewWithSeparatorLineForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (UIView *subView in cell.contentView.subviews) {
        if ([subView isKindOfClass:[UIView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    if (indexPath.row == 0) {
        UIView *lineView = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY:0.0 width:SCREEN_WIDTH direction:0];
        [cell.contentView addSubview:lineView];
    }else {
        UIView *lineView = [ZRCommonView generateSeperatorLineWithOriginX:16.0 originY:0.0 width:SCREEN_WIDTH - 16.0 direction:0];
        [cell.contentView addSubview:lineView];
    }
    
    if (indexPath.row == [[self.tableViewTitleArray objectAtIndex:indexPath.section] count] - 1) {
        UIView *lineView = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY:43.0 -.5 width:SCREEN_WIDTH direction:0];
        [cell.contentView addSubview:lineView];
    }
}

#pragma mark - Private Methods
/// 自定义弹出窗口，标题均为“提示”有两个按钮
- (UIAlertView *)showAlertViewWithMessage:(NSString *)message type:(ZRAlertViewType)alertType {
    
    UIAlertView *alertView = nil;
    if (alertType == ZRAlertViewTypeTwoButton) {
        alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }else if (alertType == ZRAlertViewTypeOneButton) {
        alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
    }
    return alertView;
}


#pragma mark - Actions
/// 点击退出登录按钮
- (void)clickLogoutButton:(UIButton *)button {

    //  退出登录
    NSLog(@"退出登录");
    [[self showAlertViewWithMessage:@"确定要退出登录？" type:ZRAlertViewTypeTwoButton] show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 1) {
        //  确定按钮
        [[ZRUser sharedInstance] clear];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.tableViewTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger number = 0;
    number = [[_tableViewTitleArray objectAtIndex:section] count];
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"SettingCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_tableViewTitleArray[indexPath.section] objectAtIndex:indexPath.row];
    
    [self tableViewCell:cell buildCellViewWithSeparatorLineForRowAtIndexPath:indexPath];
    [self tableViewCell:cell buildCellViewWithLabelForRowAtIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CGFloat headerHeight = 36.0;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 36.0)];
    
    UILabel *headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0.0, 100.0, headerHeight)];
    headerTitleLabel.font = [UIFont systemFontOfSize:12.0];
    headerTitleLabel.textColor = [UIColor zr_colorFromHex:0x6d6d72];
    [headerView addSubview:headerTitleLabel];
    
    if (section == 0) {
        headerTitleLabel.text = @"售后服务";
    }else if (section == 1) {
        headerTitleLabel.text = @"个人设置";
    }else if (section == 2) {
        headerTitleLabel.text = @"关于APP";
    }else if (section == 3) {
        headerTitleLabel.text = @"关于果园";
    }
    
    return headerView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 43.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 36.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *phoneNumber = cell.textLabel.text;
        // app内拨号
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        // 给app添加评分
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/shun-feng-you-xuan/id563194150?mt=8"]];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // 修改密码
            if ([[ZRUser sharedInstance] isLogin]) {
                
            }else {
                [[self showAlertViewWithMessage:@"您还没有登录呢，不能修改密码哦" type:ZRAlertViewTypeOneButton] show];
            }
        }else if (indexPath.row == 2) {
            // 个人信息
            if ([[ZRUser sharedInstance] isLogin]) {
                
            }else {
                [[self showAlertViewWithMessage:@"您还没有登录呢，不能查看个人信息哦" type:ZRAlertViewTypeOneButton] show];
            }
        }
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //  取消TableView HeaderView黏性
    CGFloat sectionHeaderHeight = 36.0;
    CGFloat yOffset = scrollView.contentOffset.y + PHONE_STATUSBAR_HEIGHT + PHONE_NAVIGATIONBAR_HEIGHT;
    if (yOffset >= 0 && yOffset <= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0.0, 0.0, 0.0);
    }else if (yOffset > sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(- sectionHeaderHeight + PHONE_STATUSBAR_HEIGHT + PHONE_NAVIGATIONBAR_HEIGHT, 0.0, 0.0, 0.0);
    }
}

@end
