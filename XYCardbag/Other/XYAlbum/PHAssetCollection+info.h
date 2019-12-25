//
//  PHAssetCollection+info.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAssetCollection (info)

@property (nonatomic, strong) PHFetchResult *assets;

@end

NS_ASSUME_NONNULL_END
