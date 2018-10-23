//
//  XYQRCodeTool.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/23.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYQRCodeTool.h"

@implementation XYQRCodeTool

+ (UIImage *)qrCodeWithContent:(NSString *)content size:(CGFloat)size
{
    // 1.创建滤镜对象
    CIFilter *fiter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.设置相关属性
    [fiter setDefaults];
    
    // 3.设置输入数据
    NSString *inputData = content;
    NSData *data = [inputData dataUsingEncoding:NSUTF8StringEncoding];
    [fiter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出结果
    CIImage *outputImage = [fiter outputImage];
    
    // 5.显示二维码
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
