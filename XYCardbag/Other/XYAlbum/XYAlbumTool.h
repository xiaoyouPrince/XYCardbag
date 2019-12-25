//
//  XYAlbumTool.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHAssetCollection+info.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYAlbumTool : NSObject

/**
TODO:获取相册

@param contentBlock 回调
*/
+ (void)fetchAlbumsCollectionBack:(void(^)(NSArray *collection))contentBlock;

/**
 TODO:x权限设置页面
 */
+ (void)prowerSetView;

/**
 TODO:x获取当前view最近的VC
 */
+ (UIViewController *)getCurrentVCForView:(UIView *)view;

/**
TODO:x请求PHAsset下面的图片
*/
+ (PHImageRequestID)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *, NSDictionary *, BOOL isDegraded))completion;

@end

NS_ASSUME_NONNULL_END
