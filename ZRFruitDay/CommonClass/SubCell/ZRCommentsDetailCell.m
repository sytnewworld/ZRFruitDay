//
//  ZRCommentsDetailCell.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/2/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  商品评价详情页cell
//

#import "ZRCommentsDetailCell.h"
#import "CommonDefines.h"
#import "UIImageView+WebCache.h"
#import "ZRCommonView.h"

@interface ZRCommentsDetailCell ()

/// 星级图标
@property (nonatomic, strong) UIView *starIconView;
/// 评价人昵称
@property (nonatomic, strong) UILabel *userNameLabel;
/// 评价时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 评价内容
@property (nonatomic, strong) UILabel *contentsLabel;
/// 评价内容高度
@property (nonatomic, assign) CGFloat labelHeight;
/// 分割线
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZRCommentsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

#pragma mark - Build View
/// 初始化cell的视图
- (void)buildCellView {

    // 星级图标
    self.starIconView = [ZRCommonView customStarIconViewWithOrigin:CGPointMake(6.0, 10.0) IconWidth:14.0 iconSpace:11.0 level:5];
    [self.contentView addSubview:_starIconView];
    
    //  评价人昵称
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_starIconView.frame) + 15.0, 10.0, 89.0, 12.0 )];
    _userNameLabel.textColor = COLOR_GRAY_TITLE;
    _userNameLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_userNameLabel];
    
    // 评价时间
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userNameLabel.frame) + 15.0, 10.0, 77.0, 12.0)];
    _timeLabel.textColor = COLOR_GRAY_TITLE;
    _timeLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_timeLabel];
    
    //  评价内容
    self.contentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(6.0, 30.0, SCREEN_WIDTH - 6.0 - 6.0, _labelHeight)];
    _contentsLabel.font = [UIFont systemFontOfSize:14.0];
    _contentsLabel.textColor = [UIColor blackColor];
    _contentsLabel.numberOfLines = 10;
    [self.contentView addSubview:_contentsLabel];
    
    //  分割线
    CGFloat cellHeight = CGRectGetHeight(self.frame);
    self.lineView = [ZRCommonView generateSeperatorLineWithOriginX:9.0 originY:cellHeight width:SCREEN_WIDTH - 9.0 direction:0];
    [self.contentView addSubview:_lineView];
}

#pragma mark - Private Methods
- (void)setCommentsDetail:(CommentsDetail *)commentsDetail {

    _commentsDetail = commentsDetail;
    [self loadCellData];
}

/// 加载cell数据
- (void)loadCellData {
    
    self.userNameLabel.text = self.commentsDetail.user_name;
    //  获取时间
    NSArray *timeArray = [self.commentsDetail.time componentsSeparatedByString:@" "];
    self.timeLabel.text = [timeArray objectAtIndex:0];
    self.contentsLabel.text = self.commentsDetail.content;
    [self changeCellHeight];
    //  判断是否有晒图，有晒图需添加ImageView,根据数量调整cell的frame
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    if (self.commentsDetail.images.count > 0) {
        [self buildSharedIconImageView];
    }
}

/// 设置评价内容时,修改cell的高度
- (void)changeCellHeight {
    
    //  计算Label的高度
    CGSize size = CGSizeMake(CGRectGetWidth(_contentsLabel.frame), 1000);
    CGSize labelSize = [self.contentsLabel.text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:_contentsLabel.font} context:nil].size;
    CGRect frameLabel = _contentsLabel.frame;
    frameLabel.size.height = labelSize.height;
    _contentsLabel.frame = frameLabel;
}

/// 添加ImageViews评价晒图
- (void)buildSharedIconImageView {

    //  图片边距
    CGFloat edgeInset = (SCREEN_WIDTH - 100.0 * 3)/4;
    //  当前行数
    NSInteger currentRow = 0;
    //  当前图片所在行中的位置
    NSInteger currentIndex = 0;
    //  评价晒图一行三个
    for (NSInteger i = 0; i < self.commentsDetail.images.count; i++) {
        if (i % 3 == 0) {
            currentRow++;
        }
        currentIndex = i % 3;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100.0 * currentIndex + edgeInset * (currentIndex + 1), 11.0 + (100.0 + edgeInset) * (currentRow - 1) + CGRectGetMaxY(self.contentsLabel.frame), 100.0, 100.0)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.commentsDetail.images objectAtIndex:i]]];
        [self.contentView addSubview:imageView];
        
        UIControl *control = [[UIControl alloc] initWithFrame:imageView.frame];
        control.tag = i + 1;
        [control addTarget:self action:@selector(clickImageView:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:control];
    }
}

#pragma mark - Actions
/// 点击晒图时，弹出大图
- (void)clickImageView:(UIControl *)control {

    self.showWholeImageView(control.tag);
}

- (void)layoutSubviews {

    [super layoutSubviews];
    //  分割线
    self.lineView.frame = CGRectMake(9.0, CGRectGetHeight(self.frame) - .5, SCREEN_WIDTH - 9.0, .5);
}

@end
