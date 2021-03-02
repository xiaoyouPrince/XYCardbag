//
//  XYAlbumTool.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "XYAlbumTool.h"
#import <Photos/Photos.h>
#import "XYAlertView.h"

@implementation XYAlbumTool

/**
 TODO:x权限设置页面
 */
+ (void)prowerSetView{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *setUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (@available(iOS 10.0, *)){//ios10以后
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:setUrl options:@{} completionHandler:^(BOOL success) {
                if (!success) {
                    [XYAlertView showAlertOnVC:nil title:@"提示" message:@"无法跳转到设置，请自行前往。" okTitle:@"好的" Ok:nil];
                }
            }];
        }else{
            [XYAlertView showAlertOnVC:nil title:@"提示" message:@"无法跳转到设置，请自行前往。" okTitle:@"好的" Ok:nil];
        }
    }else{
        if ([application canOpenURL:setUrl]) {
            [application openURL:setUrl];
        }else{
            [XYAlertView showAlertOnVC:nil title:@"提示" message:@"无法跳转到设置，请自行前往。" okTitle:@"好的" Ok:nil];
        }
    }
}

/**
 TODO:x获取当前view最近的VC
 */
+ (UIViewController *)getCurrentVCForView:(UIView *)view
{
    UIViewController *result = nil;
    UIResponder *responder = view.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:UIViewController.class]) {
            result = (UIViewController *)responder;
            break;
        }
        responder = responder.nextResponder;
    }
    
    return result;
}

/**
 TODO:获取相册

 @param contentBlock 回调
 */
+ (void)fetchAlbumsCollectionBack:(void(^)(NSArray *collection))contentBlock{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){//检查权限
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized:{//有权限
                    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
                    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
                    PHFetchResult<PHAssetCollection *> *regularAssetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
                    [list addObjectsFromArray:[assetCollections objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, assetCollections.count)]]];
                    //所有图片移动的第一位
                    NSInteger index = -1;
                    for (PHAssetCollection *collection in list) {
                        if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                            index = [list indexOfObject:collection];
                            break;
                        }
                    }
                    if (index>-1) {
                        PHAssetCollection *assetCollection = [list objectAtIndex:index];
                        [list removeObject:assetCollection];
                        [list insertObject:assetCollection atIndex:0];
                    }
                    [list addObjectsFromArray:[regularAssetCollections objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, regularAssetCollections.count)]]];
                    if (contentBlock) {
                        contentBlock(list);
                    }
                    break;
                }
                default:{//没权限
                    NSLog(@"2");
                    break;
                }
            }
        });
    }];
}


+ (PHImageRequestID)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *, NSDictionary *, BOOL isDegraded))completion{
    size.width *= 2;
    size.height *= 2;
    ;
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    option.resizeMode = resizeMode;//控制照片尺寸
    //    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    //option.synchronous = YES;
    //        option.networkAccessAllowed = YES;
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    PHImageRequestID imageRequestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
        if (downloadFinined && result) {
            if (completion) completion(result,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
        }
        // Download image from iCloud / 从iCloud下载图片
        if ([info objectForKey:PHImageResultIsInCloudKey] && !result) {
            PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
            option.networkAccessAllowed = YES;
            option.resizeMode = PHImageRequestOptionsResizeModeFast;
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                UIImage *resultImage = [UIImage imageWithData:imageData scale:0.1];
//                resultImage = [SRAlbumHelper scaleImage:resultImage toSize:size];
                if (resultImage) {
                    if (completion) completion(resultImage,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
                }
            }];
        }
        
        
        //        completion(image);
    }];
    return imageRequestID;
}


@end
