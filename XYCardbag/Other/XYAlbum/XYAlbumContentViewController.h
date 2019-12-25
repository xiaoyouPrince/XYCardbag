//
//  XYAlbumContentViewController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XYAlbumContentControllerDelegate <NSObject>

/**
 TODO:相册照片获取
 
 @param images 图片列表
 */
- (void)didFinishAlbumContentPickingImages:(NSArray *)images;


/**
 TODO:相册视频获取

 @param vedios 视频列表
 */
- (void)didFinishAlbumContentPickingVedios:(NSArray *)vedios;
@end

@interface XYAlbumContentViewController : UIViewController

@property (nonatomic, weak) id<XYAlbumContentControllerDelegate>delegate;
@property (nonatomic, strong) PHAssetCollection *assetCollection;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
