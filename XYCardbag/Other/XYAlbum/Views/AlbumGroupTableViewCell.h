//
//  AlbumGroupTableViewCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlbumGroupTableViewCell : UITableViewCell
@property (nonatomic, strong) PHAssetCollection *data;
@end

NS_ASSUME_NONNULL_END
