//
//  ImageCollectionViewCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAlbumTool.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ImageCollectionViewCellDelegate <NSObject>

/**
 TODO:操作事件

 @param data 资源数据
 */
- (void)didOperationAction:(PHAsset *)data;

@end

@interface ImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<ImageCollectionViewCellDelegate>delegate;
/** photoData */
@property (nonatomic, strong)       PHAsset * photoData;

@end

NS_ASSUME_NONNULL_END
