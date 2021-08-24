//
//  XYImageBrowserViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/8/16.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYImageBrowserViewController.h"

@interface XYImageBrowserViewController ()<UIScrollViewDelegate>

@end

@implementation XYImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%d/%lu",1,(unsigned long)self.images.count];
    
    if (self.images.count == 1) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images.firstObject];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.centerY.equalTo(self.view);
        }];
        
    }else{
        
        UIScrollView *scrollView = [UIScrollView new];
        [self.view addSubview:scrollView];
        scrollView.delegate = self;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
            
        
        UIView *contentView = [UIView new];
        [scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(@(ScreenH-kNavHeight-kTabSafeHeight));
        }];
        
        UIView *lastView = nil;
        for (UIImage *img in self.images) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            [contentView addSubview:imageView];
            
            CGFloat imgH = img.size.height / img.size.width * ScreenW ;
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.left.equalTo(lastView).offset(ScreenW);
                    make.right.equalTo(contentView);
                }else{
                    make.left.equalTo(contentView);
                }
                make.size.mas_equalTo(CGSizeMake(ScreenW, imgH));
                make.centerY.equalTo(contentView);
            }];
            
            lastView = imageView;
        }
        
        scrollView.pagingEnabled = YES;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    uint page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    page += 1; // 默认从1开始计数
    self.title = [NSString stringWithFormat:@"%d/%lu",page,(unsigned long)self.images.count];
}



@end
