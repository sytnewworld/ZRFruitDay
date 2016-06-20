//
//  ZRShoppingCartViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/1/22.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  购物车 测试Apple Pay
//

#import "ZRShoppingCartViewController.h"
#import <PassKit/PassKit.h>
#import "ZRFourCornersLine.h"

@interface ZRShoppingCartViewController ()<PKPaymentAuthorizationViewControllerDelegate> {

    MyLayerDelegate *_layerDelegate;
}
@end

@implementation ZRShoppingCartViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    if ([PKPaymentAuthorizationViewController canMakePayments]) {
        UIButton *button = [PKPaymentButton buttonWithType:PKPaymentButtonTypePlain style:PKPaymentButtonStyleBlack];
        button.frame = CGRectMake(10.0, 80.0, 100.0, 30.0);
        [button addTarget:self action:@selector(showAuthorizationViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    [self buildLabel];
    
    ZRFourCornersLine *fourCornersLine = [ZRFourCornersLine drawFourCornersViewWithFrame:CGRectMake(50, 120, 200.0, 300.0)];
    [self.view addSubview:fourCornersLine];
}

//  test label两行内容居中显示
- (void)buildLabel {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 300.0, 150.0, 50.0)];
    label.backgroundColor = [UIColor grayColor];
    
    label.text = @"第一行内容要许多内容\n第二行少";
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor blueColor];
    label.numberOfLines = 2;
    [self.view addSubview:label];
}

/// 展示
- (void)showAuthorizationViewController {
    
    PKPaymentRequest *request = [[PKPaymentRequest alloc] init];
    request.countryCode = @"US";
    request.currencyCode = @"USD";
    request.supportedNetworks = [NSArray arrayWithObjects:PKPaymentNetworkVisa, PKPaymentNetworkChinaUnionPay,PKPaymentNetworkAmex, nil];
    request.merchantCapabilities = PKMerchantCapability3DS | PKMerchantCapabilityEMV;
    request.merchantIdentifier = @"merchant.$(EMPORIUM_BUNDLE_PREFIX).Emporium";
    
    request.requiredBillingAddressFields = PKAddressFieldPhone;
    request.requiredShippingAddressFields = PKAddressFieldPostalAddress;
    
    request.paymentSummaryItems = [self buildSummaryItems];
    
    PKPaymentAuthorizationViewController *viewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
    if (!viewController) { /* ... Handle error ... */
        viewController.delegate = self;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

/// 概要项初始化
- (NSArray *)buildSummaryItems {
    
    NSDecimalNumber *food = [NSDecimalNumber decimalNumberWithMantissa:13456 exponent:-2 isNegative:NO];
    PKPaymentSummaryItem *foodItem = [PKPaymentSummaryItem summaryItemWithLabel:@"food" amount:food];
    
    NSDecimalNumber *play = [NSDecimalNumber decimalNumberWithMantissa:41214 exponent:-2 isNegative:NO];
    PKPaymentSummaryItem *playItem = [PKPaymentSummaryItem summaryItemWithLabel:@"play" amount:play];
    
    NSDecimalNumber *discount = [NSDecimalNumber decimalNumberWithMantissa:31242 exponent:-2 isNegative:YES];
    PKPaymentSummaryItem *discountItem = [PKPaymentSummaryItem summaryItemWithLabel:@"discount" amount:discount];
    
    NSDecimalNumber *total = [NSDecimalNumber zero];
    total = [total decimalNumberByAdding:food];
    total = [total decimalNumberByAdding:play];
    total = [total decimalNumberByAdding:discount];
    PKPaymentSummaryItem *totalItem = [PKPaymentSummaryItem summaryItemWithLabel:@"FruitDay Company" amount:total];
    
    NSArray *summaryItems = @[foodItem, playItem, discountItem, totalItem];
    return summaryItems;
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate
///  将要进行授权交易
- (void)paymentAuthorizationViewControllerWillAuthorizePayment:(PKPaymentAuthorizationViewController *)controller {
    
    
}

///  授权支付交易
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion {
    
    PKPaymentAuthorizationStatus status;
    
    completion(status);
}

/// 授权支付完成
- (void) paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

@end
