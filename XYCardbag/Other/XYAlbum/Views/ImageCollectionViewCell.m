//
//  ImageCollectionViewCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "XYAlbumTool.h"
#import "Masonry.h"

@interface ImageCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageVoew;

@end

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageVoew.contentMode = UIViewContentModeScaleAspectFill;
}


- (void)setPhotoData:(PHAsset *)photoData
{
    _photoData= photoData;
    
    // 请求图片
    [SVProgressHUD show];
    [XYAlbumTool requestImageForAsset:photoData size:CGSizeMake(200, 200) resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage * _Nonnull image, NSDictionary * _Nonnull info, BOOL isDegraded) {
        
        [SVProgressHUD dismiss];
        self.imageVoew.image = image;
    }];
    
    // 只有图片可以用，非图片类型，进行一个灰色蒙版禁用
    if (photoData.mediaType != PHAssetMediaTypeImage) {
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.5];
        [self.imageVoew addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.imageVoew);
        }];
    }
}

@end
