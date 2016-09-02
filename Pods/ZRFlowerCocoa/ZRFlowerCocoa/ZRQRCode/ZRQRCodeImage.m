//
//  ZRQRCodeImage.m
//  ZRGeneratorQRCode
//
//  Created by ZRFlower on 16/9/1.
//  Copyright © 2016年 ZRFlower. All rights reserved.
//

#import "ZRQRCodeImage.h"
@import CoreImage;

@implementation ZRQRCodeImage

/// 根据url生成相应的二维码图片(黑白相间)
+ (UIImage *)generateQRCodeImageWithURL:(NSString *)url imageSize:(CGFloat)size {
    
    CIImage *originImage = [ZRQRCodeImage generatorQRCodeImageWithURL:url];
    UIImage *resultImage = [ZRQRCodeImage changeImageSizeWithCIImage:originImage andSize:size];
    return resultImage;
}

/**
 *  根据url、大小和颜色生成相应的二维码图片
 *
 *  @param url   二维码中的链接
 *  @param size  二维码大小
 *  @param red   RGB中的红色(0~255)
 *  @param green RGB中的绿色(0~255)
 *  @param blue  RGB中的蓝色(0~255)
 *
 *  @return 二维码图片
 */
+ (UIImage *)generateQRCodeImageWithURL:(NSString *)url imageSize:(CGFloat)size colorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue {
    
    UIImage *image = [ZRQRCodeImage generateQRCodeImageWithURL:url imageSize:size];
    UIImage *resultImage = [ZRQRCodeImage imageBlackToTransparent:image withRed:red andGreen:green andBlue:blue];
    return resultImage;
}

/**
 *  根据url生成相应的带水印图片的二维码图片(黑白相间)
 *
 *  @param url           二维码中的链接
 *  @param size          二维码大小
 *  @param logoImage     二维码中的logo图标
 *  @param logoImageSize logo图标的大小
 *
 *  @return 二维码图片
 */
+ (UIImage *)generateQRCodeWaterMarkImageWithURL:(NSString *)url imageSize:(CGFloat)size logoImage:(UIImage *)logoImage logoImageSize:(CGSize)logoImageSize {

    UIImage *image = [ZRQRCodeImage generateQRCodeImageWithURL:url imageSize:size];
    UIImage *resultImage = [ZRQRCodeImage addImageToSuperImage:image withSubImage:logoImage andSubImagePosition:CGRectMake((size - logoImageSize.width)/2, (size - logoImageSize.height)/2, logoImageSize.width, logoImageSize.height)];
    return resultImage;
}

/**
 *  根据url、大小、logo图标和颜色生成相应的带水印图片的二维码图片
 *
 *  @param url           二维码中的链接
 *  @param size          二维码大小
 *  @param logoImage     二维码中的logo图标
 *  @param logoImageSize logo图标的大小
 *  @param red           RGB中的红色(0~255)
 *  @param green         RGB中的绿色(0~255)
 *  @param blue          RGB中的蓝色(0~255)
 *
 *  @return 二维码图片
 */
+ (UIImage *)generateQRCodeWaterMarkImageWithURL:(NSString *)url imageSize:(CGFloat)size logoImage:(UIImage *)logoImage logoImageSize:(CGSize)logoImageSize colorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue {

    UIImage *image = [ZRQRCodeImage generateQRCodeImageWithURL:url imageSize:size colorWithRed:red Green:green Blue:blue];
    UIImage *resultImage = [ZRQRCodeImage addImageToSuperImage:image withSubImage:logoImage andSubImagePosition:CGRectMake((size - logoImageSize.width)/2, (size - logoImageSize.height)/2, logoImageSize.width, logoImageSize.height)];
    return resultImage;
}

/// 根据url生成相应的二维码图片CIImage
+ (CIImage *)generatorQRCodeImageWithURL:(NSString *)URL {

    //  1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //  2.设置滤镜的默认属性
    [filter setDefaults];
    //  3.将url字符串转换为NSData
    NSData *data = [URL dataUsingEncoding:NSUTF8StringEncoding];
    //  4.通过KVO设置滤镜的inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //  5.获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

/**
 *  改变图片大小 (正方形图片)
 *
 *  @param ciImage 需要改变大小的CIImage 对象的图片
 *  @param size    图片大小 (正方形图片 只需要一个数)
 *
 *  @return 生成的目标图片
 */
+ (UIImage *)changeImageSizeWithCIImage:(CIImage *)ciImage andSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

/// 更改二维码的颜色
+ (UIImage *)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue {
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

/**
 *  图片增加水印
 *
 *  @param superImage 需要增加水印的图片
 *  @param subImage   水印图片
 *  @param posRect    水印的位置 和 水印的大小
 *
 *  @return 加水印后的新图片
 */
+ (UIImage *)addImageToSuperImage:(UIImage *)superImage withSubImage:(UIImage *)subImage andSubImagePosition:(CGRect)posRect {
    
    UIGraphicsBeginImageContext(superImage.size);
    [superImage drawInRect:CGRectMake(0, 0, superImage.size.width, superImage.size.height)];
    //四个参数为水印图片的位置
    [subImage drawInRect:posRect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
