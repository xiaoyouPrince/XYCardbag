//
//  XYAlbumViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//
//  一个相册展示的VC,本页面展示相册列表


#import "XYAlbumViewController.h"
#import "XYAlbumGroupViewController.h"

@interface XYAlbumViewController ()

@end

@implementation XYAlbumViewController

/// 加载相册样式
- (instancetype)initWithAlbum{
    // 跳转到组列表页
    XYAlbumGroupViewController *group = [XYAlbumGroupViewController new];
    self = [super initWithRootViewController:group];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}


@end
