//
//  XYQrCodeView.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/22.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYQrCodeView.h"
#import "XYQRCodeTool.h"
#import "Masonry.h"

@interface XYQrCodeView()
@property(nonatomic , weak)    UIImageView *qrView;
@property(nonatomic , weak)    UILabel *contentLabel;
@property(nonatomic , copy)     NSString *content;
@end

@implementation XYQrCodeView

+ (instancetype)qrCodeViewWithContent:(NSString *)content{
    
    // 创建固定大小的view实例对象
    
    // qrView 100 * 100 中间
    
    XYQrCodeView *instance = [XYQrCodeView new];
    instance.content = content;
    
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent{
    
    CGFloat size = ScreenW/3;
    
    
    UIImageView *iv = [UIImageView new];
    [self addSubview:iv];
    self.qrView = iv;
    
    UILabel *contentLabel = [UILabel new];
    [self addSubview:contentLabel];
    contentLabel.font = [UIFont boldSystemFontOfSize:17];
    self.contentLabel = contentLabel;
    
    
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(size));
        make.center.equalTo(self);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-15);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.qrView.image = [XYQRCodeTool qrCodeWithContent:self.content size:self.qrView.xy_width];
    self.contentLabel.text = self.content;
}


@end
