//
//  PHAssetCollection+info.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "PHAssetCollection+info.h"
#import <objc/runtime.h>

@implementation PHAssetCollection (info)

- (void)setAssets:(PHFetchResult *)assets{
    objc_setAssociatedObject(self, @selector(assets), assets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PHFetchResult *)assets{
    PHFetchResult *result = objc_getAssociatedObject(self, _cmd);
    if (result == nil) {
        result = [PHAsset fetchAssetsInAssetCollection:self options:nil];
        self.assets = result;
    }
    return result;
}

@end
