//
//  XYQrCodeView.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/22.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYQrCodeView : UIView

/**
 快速创建一个QRCodeView

 @param content qr内容
 @return qrCodeView
 */
+ (instancetype)qrCodeViewWithContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
