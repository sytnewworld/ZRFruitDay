//
//  ZRRichScanViewController.m
//  ZRFruitDay
//
//  Created by ShiYangtao on 16/3/8.
//  Copyright © 2016年 ShiYangtao. All rights reserved.
//  扫一扫功能
//

#import "ZRRichScanViewController.h"

@interface ZRRichScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

/// 捕捉对象
@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation ZRRichScanViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setupCamera];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    if (_captureSession && ![_captureSession isRunning]) {
        [_captureSession startRunning];
    }
}

/// 设置相机
- (void)setupCamera {

    // 初始化捕捉对象
    _captureSession = [[AVCaptureSession alloc] init];
    //  初始化输入对象
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    [_captureSession addInput:input];
    //  初始化输出对象
    AVCaptureMetadataOutput *captureMetamaOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetamaOutput];
    
    //  设置扫描内容(这里只设置条形码),ps:通常放置在主线程,如果在子线程回调会很慢
    [captureMetamaOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [captureMetamaOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode,nil]];
    //  初始化显示层(将相机capture到内容展示到layer层上)
    AVCaptureVideoPreviewLayer *videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CGRect frame = CGRectMake(20.0, 100.0, 280.0, 280.0);
    [videoPreviewLayer setFrame:frame];
    [self.view.layer addSublayer:videoPreviewLayer];
    
    //  开始
    [_captureSession startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {

    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //  metadataObj.stringValue就是扫描获得的文字，对它进行操作即可
        //  将获得的nesting回传并popViewController就能实现gif的效果
        NSLog(@"%@",metadataObj.stringValue);
        [_captureSession stopRunning];
        if ([metadataObj.stringValue hasPrefix:@"http://weixin.qq.com"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://app/wx9c8771d3c07dfd30/"]];
        }
        [self.navigationController popViewControllerAnimated:NO];

    }
}

@end
