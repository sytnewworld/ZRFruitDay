
//
//  ZRFruitEatTableViewCell.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/1.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  果食页面cell
//

#import "ZRFruitEatTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommonDefines.h"
#import "ZRCommonView.h"

static NSString *cellIdentifier = @"ZRFruitEatTableViewCell";

@interface ZRFruitEatTableViewCell ()

// 图片
@property (nonatomic, strong) UIImageView *iconImageView;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 概要
@property (nonatomic, strong) UILabel *summaryLabel;
//  点赞按钮
@property (nonatomic, strong) UIButton *upvoteButton;
//  评论按钮
@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation ZRFruitEatTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ReleaseContent *)releaseContent {
    
    ZRFruitEatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZRFruitEatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.releaseContentData = releaseContent;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

#pragma mark - Build View
/// 搭建cell视图
- (void)buildCellView {
    
    // 图片
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 90.0, 90.0)];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    
    // 标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+ 8.0, 14.0, SCREEN_WIDTH - CGRectGetMaxX(_iconImageView.frame) - 8.0 - 15.0, 16.0)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    _titleLabel.textColor = COLOR_TITLE_BLACK;
    [self.contentView addSubview:_titleLabel];
    
    // 概要
    self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 8.0, CGRectGetMaxY(_titleLabel.frame) + 7.0, CGRectGetWidth(_titleLabel.frame), 35.0)];
    _summaryLabel.numberOfLines = 2;
    _summaryLabel.font = [UIFont systemFontOfSize:13.0];
    _summaryLabel.textColor = COLOR_GRAY_TITLE;
    _summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_summaryLabel];
 
    //  点赞按钮
    self.upvoteButton = [self buildCommonButtonWithFrame:CGRectMake(SCREEN_WIDTH - 107.0, 110.0 - 15.0 - 12.0, 33.0, 15.0) title:@"" image:@"upvote"];
    [_upvoteButton addTarget:self action:@selector(clickUpvoteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_upvoteButton];
    
    //  评论按钮
    self.commentButton = [self buildCommonButtonWithFrame:CGRectMake(SCREEN_WIDTH - 44.0 - 15.0, _upvoteButton.frame.origin.y, 33.0, 15.0) title:@"" image:@"comment"];
    [self.contentView addSubview:_commentButton];
    
    //  添加分割线
    UIView *lineView = [ZRCommonView generateSeperatorLineWithOriginX:0.0 originY: 110.0 - .5 width:SCREEN_WIDTH direction:0];
    [self.contentView addSubview:lineView];
}

- (void)setReleaseContentData:(ReleaseContent *)releaseContentData {

    _releaseContentData = releaseContentData;
    
    //  加载数据
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_releaseContentData.photo]];
    _titleLabel.text = _releaseContentData.title;
    _summaryLabel.text = _releaseContentData.summary;
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_summaryLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7.0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _summaryLabel.text.length)];
    _summaryLabel.attributedText = attributedString;
    
    [_upvoteButton setTitle:_releaseContentData.worth_num forState:UIControlStateNormal];
    if ([_releaseContentData.is_worth isEqualToString:@"1"]) {
        [_upvoteButton setImage:[UIImage imageNamed:@"upvoteHighlight"] forState:UIControlStateNormal];
    }
    // 根据点赞数量调整Button位置,原则为右对齐
    CGSize size = CGSizeMake(60.0, CGRectGetHeight(_upvoteButton.frame));
    CGSize upvoteButtonSize = [_upvoteButton.titleLabel.text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: _upvoteButton.titleLabel.font} context:nil].size;
    CGRect upvoteButtonFrame = _upvoteButton.frame;
    upvoteButtonFrame.origin.x = SCREEN_WIDTH - 107.0 - upvoteButtonSize.width + 15.0;
    upvoteButtonFrame.size.width = upvoteButtonSize.width + 33.0;
    _upvoteButton.frame = upvoteButtonFrame;
    
    [_commentButton setTitle:_releaseContentData.comment_num forState:UIControlStateNormal];
    //  根据评论数调整Button位置,原则为右对齐
    CGSize sizeModel = CGSizeMake(60.0, CGRectGetHeight(_commentButton.frame));
    CGSize commentButtonSize = [_commentButton.titleLabel.text boundingRectWithSize:sizeModel options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: _commentButton.titleLabel.font} context:nil].size;
    CGRect commentButtonFrame = _commentButton.frame;
    commentButtonFrame.origin.x = SCREEN_WIDTH - 44.0 - commentButtonSize.width + 15.0 - 15.0;
    commentButtonFrame.size.width = commentButtonSize.width + 33.0;
    _commentButton.frame = commentButtonFrame;
}

/// 搭建点赞按钮和评论视图的公共部分
- (UIButton *)buildCommonButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image {

    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:COLOR_HALF_GRAY_TITLE forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10.0];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    return button;
}

/// 响应点赞按钮的操作
- (void)clickUpvoteButton:(UIButton *)button {

    _isUpvote = !_isUpvote;
    //  改变点赞数值和按钮图片
    NSInteger worth_num = [_upvoteButton.titleLabel.text integerValue];
    NSString *image = nil;
    if (_isUpvote) {
        worth_num ++;
        image = @"upvoteHighlight";
    }else {
        worth_num --;
        image = @"upvote";
    }
    [self.upvoteButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.upvoteButton setTitle:[NSString stringWithFormat:@"%ld", worth_num] forState:UIControlStateNormal];
}

@end
