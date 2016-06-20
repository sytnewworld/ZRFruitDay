//
//  ZRWebViewDetailViewController.h
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/21.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  展示webview的详细内容
//  

#import "ZRBaseViewController.h"

@interface ZRWebViewDetailViewController : ZRBaseViewController

//  根据资源传递的url初始化
- (id)initWithLinkURL:(NSString *)linkURL;

@end
