//
//  ZRQRCodeImage.h
//  ZRGeneratorQRCode
//
//  Created by ZRFlower on 16/9/1.
//  Copyright © 2016年 ZRFlower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRQRCodeImage : UIImage

/**
*  根据url生成相应的二维码图片(黑白相间)
*
*  @param url  二维码中的链接
*  @param size 二维码大小
*
*  @return 二维码图片
*/
+ (UIImage *)generateQRCodeImageWithURL:(NSString *)url imageSize:(CGFloat)size;


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
+ (UIImage *)generateQRCodeWaterMarkImageWithURL:(NSString *)url imageSize:(CGFloat)size logoImage:(UIImage *)logoImage logoImageSize:(CGSize)logoImageSize;


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
+ (UIImage *)generateQRCodeImageWithURL:(NSString *)url imageSize:(CGFloat)size colorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;


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
+ (UIImage *)generateQRCodeWaterMarkImageWithURL:(NSString *)url imageSize:(CGFloat)size logoImage:(UIImage *)logoImage logoImageSize:(CGSize)logoImageSize colorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;

@end
