//
//  XYEditViewController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XYEidtViewControllerDelegate <NSObject>

/**
 TODO:编辑图片完成

 @param image 图片
 */
- (void)imageEidtFinish:(UIImage *)image;

@end

@interface XYEditViewController : UIViewController
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id<XYEidtViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
