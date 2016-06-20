//
//  ZRWebViewDetailViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/21.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  展示webview的详细内容
//

#import "ZRWebViewDetailViewController.h"

@interface ZRWebViewDetailViewController ()<UIWebViewDelegate,ZRCommonViewDelegate>
/// webview的链接地址URL
@property (nonatomic, strong) NSString *linkURL;
/// webview
@property (nonatomic, strong) UIWebView *webView;
/// 当前的URL
@property (nonatomic, strong) NSString *currentURL;

@end

@implementation ZRWebViewDetailViewController

#pragma mark - Life Cycle
- (id)initWithLinkURL:(NSString *)linkURL {
    
    if (self = [super init]) {
        self.linkURL = linkURL;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupHTML];
    [self customNavigationBar];
}

#pragma mark - Build View
/// 自定义NavigationBar
- (void)customNavigationBar {

    UIView *navigationBarView = [ZRCommonView customNavigationBarWithDelegate:self];
    [self.view addSubview:navigationBarView];
    [self.view bringSubviewToFront:navigationBarView];
}

#pragma mark - Actions
/// 初始化HTML画面
- (void)setupHTML {
    
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURL *url = [NSURL URLWithString:self.linkURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
//  加载前
- (void)webViewDidStartLoad:(UIWebView *)webView {

    NSLog(@"%s",__func__);
}

//  加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    NSLog(@"%s",__func__);
}

//  是否在当前页面开始请求数据
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    self.currentURL = request.URL.absoluteString;
    //  点击链接为空时，显示空页面或者出错页面
    if ([self.linkURL isEqualToString:@""]) {
        NSLog(@"LinkURL 为空");
        return NO;
    }
    //  点击链接不是当前webview的URL
    if (![self.linkURL isEqualToString:self.currentURL] && ![self.currentURL isEqualToString:@""]) {
        ZRWebViewDetailViewController *newWebView = [[ZRWebViewDetailViewController alloc] initWithLinkURL:self.currentURL];
        [self.navigationController pushViewController:newWebView animated:YES];
        //  设置为NO,在当前页面不请求数据
        return NO;
    }
    return YES;
}

@end
