//
//  XYAlbumGroupViewController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XYAlbumGroupViewControllerDelegate <NSObject>

/**
 TODO:相册照片获取
 
 @param images 图片列表
 */
- (void)didFinishAlbumGroupPickingImages:(NSArray *)images;

/**
 TODO:相册视频获取
 
 @param vedios 视频列表
 */
- (void)didFinishAlbumGroupPickingVedios:(NSArray *)vedios;
@end

@interface XYAlbumGroupViewController : UIViewController

@property (nonatomic, weak) id<XYAlbumGroupViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
