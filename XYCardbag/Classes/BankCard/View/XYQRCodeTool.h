//
//  XYQRCodeTool.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/23.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYQRCodeTool : NSObject

/**
 快速创建一个 QRCode 图片

 @param content QRCode内容
 @param size 边长
 @return QRCodeImage
 */
+ (UIImage *)qrCodeWithContent:(NSString *)content size:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
