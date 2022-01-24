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
    self.view.backgroundColor = UIColor.blackColor;
    
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
//            make.edges.equalTo(self.view);
            make.left.top.bottom.equalTo(self.view);
            make.right.equalTo(self.view.mas_right);
        }];
           
//        scrollView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        scrollView.backgroundColor = UIColor.blackColor;
        
        NSUInteger tabbarHeight = iPhoneX ? 83 : 49;
        
        UIView *contentView = [UIView new];
        [scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(@(ScreenH-kNavHeight-tabbarHeight));
        }];
        contentView.frame = scrollView.bounds;
        
        UIView *lastView = nil;
        NSUInteger index = 0;
        for (UIImage *img in self.images) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            [contentView addSubview:imageView];
//            [scrollView addSubview:imageView];
            
            CGFloat margin = index > 0;// ? 20 : 0;
            CGFloat imgW = ScreenW;
            CGFloat imgH = img.size.height / img.size.width * ScreenW ;
            CGFloat imgX = imgW * index + margin;
            CGFloat imgY = (ScreenH - imgH)/2;
            
//            imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
            
            
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
            index += 1;
        }
        
//        scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastView.frame), 0);
        scrollView.pagingEnabled = YES;
        
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    uint page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    page += 1; // 默认从1开始计数
    self.title = [NSString stringWithFormat:@"%d/%lu",page,(unsigned long)self.images.count];
}



@end
