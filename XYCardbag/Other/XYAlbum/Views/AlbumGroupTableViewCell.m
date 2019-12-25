//
//  AlbumGroupTableViewCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "AlbumGroupTableViewCell.h"
#import "XYAlbumTool.h"

@interface AlbumGroupTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

@implementation AlbumGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setData:(PHAssetCollection *)data{
    _data = data;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",data.localizedTitle];
    self.numberLabel.text = [NSString stringWithFormat:@"(%@)",@(data.assets.count)];
    PHAsset *photoData = data.assets.lastObject;
    if (photoData) {
        
        [SVProgressHUD show];
        [XYAlbumTool requestImageForAsset:photoData size:CGSizeMake(200, 200) resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage * image, NSDictionary * info, BOOL isDegraded) {
            [SVProgressHUD dismiss];
            self.iconView.image = image;
        }];
    }else{
        self.iconView.image = [UIImage imageNamed:@"sr_no_pic_icon"];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
