//
//  ZRPersonalGardenViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  我的果园
//

#import "ZRPersonalGardenViewController.h"
#import "ZRLoginViewController.h"
#import "ZRRegisterViewController.h"
#import "ZRSettingViewController.h"

@interface ZRPersonalGardenViewController ()<UITableViewDataSource,UITableViewDelegate>

/// 整个页面是一个TableView
@property (nonatomic, strong) UITableView *tableView;
/// header容器,包含登陆注册、积分、余额、优惠劵信息
@property (nonatomic, strong) UIView *headerView;

/// 判断用户是否已经登录
@property (nonatomic, assign) BOOL isLogin;

@end

@implementation ZRPersonalGardenViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self buildTableView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - Build View
/// 初始化TableView视图
- (void)buildTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self buildHeaderView];
}

/// 顶部视图
- (void)buildHeaderView {

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 240.0)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _headerView;
    
    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 19.0 - 22.0, 31.0, 21.0, 21.0)];
    [settingButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(clickToSetting:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:settingButton];
    
    [self buildLoginRegisterView];
    [self buildPersonalInformation];
}

/// 登陆注册按钮
- (void)buildLoginRegisterView {
    
    CGFloat height = 30.0;
    //  登陆注册容器
    UIView *loginRegisterView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100.0)/2, 119.0, 100.0, height)];
    loginRegisterView.layer.cornerRadius = 15.0;
    loginRegisterView.layer.borderColor = COLOR_HALF_GRAY_TITLE.CGColor;
    loginRegisterView.layer.borderWidth = 1.0;
    [_headerView addSubview:loginRegisterView];
    
    //  登陆按钮
    UIButton *loginButton = [self buildCommonButtonWithFrame:CGRectMake(15.0, 0.0, 34.0, height) title:@"登录" textColor:COLOR_HALF_GRAY_TITLE font:[UIFont systemFontOfSize:14.0] imageName:nil];
//    loginButton.backgroundColor = [UIColor clearColor];
    loginButton.tag = 11;
    [loginRegisterView addSubview:loginButton];
    
    //  中间的分割线
    UIView *lineView = [ZRCommonView generateSeperatorLineWithOriginX:CGRectGetWidth(loginRegisterView.frame)/2 - 1.0 originY:(CGRectGetHeight(loginRegisterView.frame) - 15.0)/2 width:15.0 thickness:1.0 lineColor:COLOR_HALF_GRAY_TITLE direction:1];
    [loginRegisterView addSubview:lineView];
    
    //  注册按钮
    UIButton *registerButton = [self buildCommonButtonWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame), 0.0, 34.0, height) title:@"注册" textColor:COLOR_HALF_GRAY_TITLE font:[UIFont systemFontOfSize:14.0] imageName:nil];
//    registerButton.backgroundColor = [UIColor clearColor];
    registerButton.tag = 12;
    [loginRegisterView addSubview:registerButton];
}

/// 积分、余额、优惠劵三个按钮
- (void)buildPersonalInformation {

    CGFloat yOrigin = 240.0 - 80.0;
    CGFloat width = (SCREEN_WIDTH - 2 * 2)/3;
    CGFloat height = 80.0;
    
    //  积分
    UIButton *scoreButton = [self buildCommonButtonWithFrame:CGRectMake(0.0, yOrigin, width, height) title:@"积分"];
    scoreButton.tag = 21;
    [_headerView addSubview:scoreButton];
    //  余额
    UIButton *balanceButton = [self buildCommonButtonWithFrame:CGRectMake(CGRectGetMaxX(scoreButton.frame) + 2.0, yOrigin, width, height) title:@"余额"];
    balanceButton.tag = 22;
    [_headerView addSubview:balanceButton];
    //  优惠劵
    UIButton *couponButton = [self buildCommonButtonWithFrame:CGRectMake(CGRectGetMaxX(balanceButton.frame) + 2.0, yOrigin, width, height) title:@"优惠劵"];
    couponButton.tag = 23;
    [_headerView addSubview:couponButton];
    
    //  中间两条分割短线 高度:60.0 居中
    CGFloat lineHeight = 30.0;
    //  第一条线
    UIView *lineLeft = [ZRCommonView generateSeperatorLineWithOriginX:CGRectGetMaxX(scoreButton.frame) originY:yOrigin +(height - lineHeight)/2 width:lineHeight thickness:1.0 lineColor:COLOR_HALF_GRAY_TITLE direction:1];
    
    [_headerView addSubview:lineLeft];
    //  第二条线
    UIView *lineRight = [ZRCommonView generateSeperatorLineWithOriginX:CGRectGetMaxX(balanceButton.frame) originY:lineLeft.frame.origin.y width:lineHeight thickness:1.0 lineColor:COLOR_HALF_GRAY_TITLE direction:1];
    [_headerView addSubview:lineRight];
}

#pragma mark - Private Methods
/// 六个标题选项
- (void)buildBodyViewWithTableViewCell:(UITableViewCell *)cell {
    
    UIView *bodyView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - 240.0 - 49.0)];
    bodyView.backgroundColor = [UIColor orangeColor];
    [cell.contentView addSubview:bodyView];
    
    CGFloat width = (SCREEN_WIDTH - 1)/3;
    CGFloat height = 131.0;
    //  我的订单
    UIButton *personalOrderButton = [self buildCommonButtonWithFrame:CGRectMake(0.0, 0.0, width, height) title:@"我的订单" imageName:@""];
    personalOrderButton.tag = 31;
    [bodyView addSubview:personalOrderButton];
    
    //  待评价
    UIButton *waitForCommentButton = [self buildCommonButtonWithFrame:CGRectMake(CGRectGetMaxX(personalOrderButton.frame) + .5, 0.0, width, height) title:@"待评价" imageName:@""];
    waitForCommentButton.tag = 32;
    [bodyView addSubview:waitForCommentButton];
    
    //  会员等级
    UIButton *memberLevelButton = [self buildCommonButtonWithFrame:CGRectMake(CGRectGetMaxX(waitForCommentButton.frame) + .5, 0.0, width, height) title:@"会员等级" imageName:@""];
    memberLevelButton.tag = 33;
    [bodyView addSubview:memberLevelButton];
    
    //  我的赠品
    UIButton *personalGiftButton = [self buildCommonButtonWithFrame:CGRectMake(0.0, CGRectGetMaxY(personalOrderButton.frame) + .5, width, height) title:@"我的赠品" imageName:@""];
    personalGiftButton.tag = 41;
    [bodyView addSubview:personalGiftButton];
    
    //  我的特权
    UIButton *personalPrivilegeButton = [self buildCommonButtonWithFrame:CGRectMake(CGRectGetMaxX(personalOrderButton.frame) + .5, CGRectGetMaxY(waitForCommentButton.frame) + .5, width, height) title:@"我的特权" imageName:@""];
    personalPrivilegeButton.tag = 42;
    [bodyView addSubview:personalPrivilegeButton];
    
    //  我的试吃
    UIButton *personalTastingButton = [self buildCommonButtonWithFrame:CGRectMake(CGRectGetMaxX(personalPrivilegeButton.frame) + .5, CGRectGetMaxY(memberLevelButton.frame) + .5, width, height) title:@"我的试吃" imageName:@""];
    personalTastingButton.tag = 43;
    [bodyView addSubview:personalTastingButton];
    
    //  三条分割线  纵向:两条 横向:一条
    UIView *lineVerticalLeft = [ZRCommonView generateSeperatorLineWithOriginX:CGRectGetMaxX(personalOrderButton.frame) originY:0.0 width:height * 2 direction:1];
    [bodyView addSubview:lineVerticalLeft];
    
    UIView *lineVerticalRight = [ZRCommonView generateSeperatorLineWithOriginX:CGRectGetMaxX(waitForCommentButton.frame) originY:0.0 width:height * 2 direction:1];
    [bodyView addSubview:lineVerticalRight];
    
    UIView *lineHorizontal = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY:131.0 width:SCREEN_WIDTH direction:0];
    [bodyView addSubview:lineHorizontal];
}

/// 有图片和文字的按钮:我的订单、待评价、会员等级、我的赠品、我的特权、我的试吃
- (UIButton *)buildCommonButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName {
    
    return [self buildCommonButtonWithFrame:frame title:title textColor:COLOR_HALF_GRAY_TITLE font:[UIFont boldSystemFontOfSize:13.0] imageName:@""];
}

/// 积分、余额、优惠劵按钮
- (UIButton *)buildCommonButtonWithFrame:(CGRect)frame title:(NSString *)title {
    
    return [self buildCommonButtonWithFrame:frame title:title textColor:COLOR_HALF_GRAY_TITLE font:[UIFont boldSystemFontOfSize:14.0] imageName:nil];
}

/// 通用button设置
- (UIButton *)buildCommonButtonWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font imageName:(NSString *)imageName {

    UIButton *button = [[UIButton alloc] initWithFrame:frame];
//    button.backgroundColor = [UIColor clearColor];
    //  标题
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal & UIControlStateHighlighted];
    [button setTitleColor:color forState:UIControlStateNormal & UIControlStateHighlighted];
    //  图片
    if (imageName != nil) {
        [button.imageView setImage:[UIImage imageNamed:imageName]];
    }
    button.contentMode = UIViewContentModeCenter;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/// 登录成功之后回调
- (void)userLoginWithBlock:(ZRLoginBackBlock)completeBlock {

    if (_isLogin) {
        completeBlock();
    }else {
        //  登陆
        ZRLoginViewController *loginViewController = [[ZRLoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

#pragma mark - Actions
/// 设置按钮
- (void)clickToSetting:(UIButton *)button {

    ZRSettingViewController *settingViewController = [[ZRSettingViewController alloc] init];
    [self.navigationController  pushViewController:settingViewController animated:YES];
}

/// 响应按钮的操作
- (void)clickButton:(UIButton *)button {
    
    // 根据传递的参数，进行不同的跳转
    if (button.tag > 10 && button.tag < 20) {
        [self showLoginRegisterViewControllerWithTag:button.tag];
    }
    
    if (button.tag > 20 && button.tag < 30) {
        [self showPersonalInformationViewControllerWithTag:button.tag];
    }
    
    if (button.tag > 30 && button.tag < 50) {
        [self showPersonalExtensionActionViewControllerWithTag:button.tag];
    }
}

/// 登陆、注册页面跳转
- (void)showLoginRegisterViewControllerWithTag:(NSInteger)tag {

    if (tag == 11) {
        //  登陆
        ZRLoginViewController *loginViewController = [[ZRLoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    if (tag == 12) {
        //  注册
        ZRRegisterViewController *registerViewController = [[ZRRegisterViewController alloc] init];
        registerViewController.viewControllerType = ViewControllerTypeRegister;
        [self.navigationController pushViewController:registerViewController animated:YES];
    }
}

/// 个人信息页面跳转:积分、余额、优惠劵
- (void)showPersonalInformationViewControllerWithTag:(NSInteger)tag {

    if (tag == 21) {
        //  积分
        [self userLoginWithBlock:^{
            
        }];
    }
    if (tag == 22) {
        //  余额
        [self userLoginWithBlock:^{
            
        }];
    }
    if (tag == 23) {
        //  优惠劵
        [self userLoginWithBlock:^{
            
        }];
    }
}

/// 功能页面: 个人额外功能页面跳转
- (void)showPersonalExtensionActionViewControllerWithTag:(NSInteger)tag {

    switch (tag) {
        case 31:
            //  我的订单
            [self userLoginWithBlock:^{
                
            }];
            break;
        case 32:
            //  待评价
            [self userLoginWithBlock:^{
                
            }];
            break;
        case 33:
            //  会员等级
            [self userLoginWithBlock:^{
                
            }];
            break;
        case 41:
            //  我的赠品
            [self userLoginWithBlock:^{
                
            }];
            break;
        case 42:
            //  我的特权
            [self userLoginWithBlock:^{
                
            }];
            break;
        case 43:
            //  我的试吃
            [self userLoginWithBlock:^{
                
            }];
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ZRPersonalGardenCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [self buildBodyViewWithTableViewCell:cell];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 131.0 * 2 + 1.0;
}

@end
