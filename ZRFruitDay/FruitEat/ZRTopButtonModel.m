//
//  ZRTopButtonModel.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/4.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  果食页面顶部按钮模型
//

#import "ZRTopButtonModel.h"
#import "UIImageView+WebCache.h"
#import "CommonDefines.h"

@implementation ZRTopButtonModel

/**
 *  自定义TopButtonModel
 *
 *  @param frame         按钮的frame
 *  @param buttonBase    数据模型
 *  @param topButtonType 按钮类型
 *
 *  @return 生成的自定义按钮
 */
+ (ZRTopButtonModel *)buildTopButtonModelWithFrame:(CGRect)frame buttonBase:(ButtonBase *)buttonBase topButtonType:(FruitEatTopButtonType)topButtonType tag:(NSInteger)tag {

    ZRTopButtonModel *topButton = [[ZRTopButtonModel alloc] initWithFrame:frame];
    [topButton buildButtonModelViewWithFrame:frame buttonBase:buttonBase topButtonType:topButtonType tag:tag];
    return topButton;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)buildButtonModelViewWithFrame:(CGRect)frame buttonBase:(ButtonBase *)buttonBase topButtonType:(FruitEatTopButtonType)topButtonType tag:(NSInteger)tag {
    
    /*  规则:
     *  根据button的frame和类型type,计算图片的frame和label的frame
     *  如果只有一个Label,ImageView的宽度和高度均为56.0;两个Label时为40.0
     *  默认图片和Label之间间距为5,两个Label上下间距也为5
     *  Label的宽度定为47.0
     */
    
    //  计算ImageView的frame
    //  得到button的宽和高
    CGFloat buttonWidth = frame.size.width;
    CGFloat buttonHeight = frame.size.height;
    //  图片的宽度
    CGFloat imageViewWidth = topButtonType == 0 ? 56.0 : 40.0;
    // 包含图片和Label以及间距的高度
    CGFloat totalHeight = topButtonType == FruitEatTopButtonTypeOneLabel ? 56.0 + 5.0 + 11.0 : 40.0 + 11.0 + 5.0 * 2 + 9.0;
    //  得到ImageView的frame
    CGFloat xOriginOfImageView = (buttonWidth - imageViewWidth)/2;
    CGFloat yOriginOfImageView = (buttonHeight - totalHeight)/2;
    CGRect frameOfImageView = CGRectMake(xOriginOfImageView, yOriginOfImageView, imageViewWidth, imageViewWidth);
    //  添加图片
    UIImageView *iconImageView = [self buildImageViewWithFrame:frameOfImageView imageURL:buttonBase.photo];
    [self addSubview:iconImageView];
    //  根据ImageView的frame得到Label的frame
    CGFloat labelWidth = 47.0;
    CGRect frameOfFirstLabel = CGRectMake((buttonWidth - labelWidth)/2, CGRectGetMaxY(iconImageView.frame) + 5.0, labelWidth, 11.0);
    //  添加第一个Label
    UILabel *firstLabel = [self buildLabelWithFrame:frameOfFirstLabel labeText:buttonBase.name labelFont:[UIFont systemFontOfSize:11.0]];
    [self addSubview:firstLabel];
    
    //  根据topButtonType类型,生成第二个Label
    if (topButtonType == FruitEatTopButtonTypeTwoLabel) {
        CGRect frameOfSecondLaebl = CGRectMake(frameOfFirstLabel.origin.x,CGRectGetMaxY(frameOfFirstLabel) + 5.0, labelWidth, 9.0);
        UILabel *secondLabel = [self buildLabelWithFrame:frameOfSecondLaebl labeText:buttonBase.num labelFont:[UIFont systemFontOfSize:9.0]];
        [self addSubview:secondLabel];
    }
    
    //  添加Control
    UIControl *control = [self buildControlWithFame:self.bounds tag:tag];
    [self addSubview:control];
}

/// 模型中的ImageView
- (UIImageView *)buildImageViewWithFrame:(CGRect)frame imageURL:(NSString *)imageURL {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    return imageView;
}

/// 模型中的Label
- (UILabel *)buildLabelWithFrame:(CGRect)frame labeText:(NSString *)text labelFont:(UIFont *)font {

    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = COLOR_GRAY_TITLE;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

/// 模型中的Control,处理事件
- (UIControl *)buildControlWithFame:(CGRect)frame tag:(NSInteger)tag {

    UIControl *control = [[UIControl alloc] initWithFrame:frame];
    control.tag = tag;
    [control addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    return control;
}

/// 点击该模型的响应事件
- (void)clickControl:(UIControl *)control {

    NSLog(@"%ld",control.tag);
}

@end
