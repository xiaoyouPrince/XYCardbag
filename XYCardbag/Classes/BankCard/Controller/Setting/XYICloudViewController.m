//
//  XYICloudViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/9/5.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYICloudViewController.h"

@interface XYICloudViewController ()

@end

@implementation XYICloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.text = @"说明: \n"
    "iCloud 功能用于同步 App 内数据到 Apple iCloud 账户中，"
    "iCloud 账户数据可在多台登录的苹果设备中共享。\n";
    [self setHeaderView:label edgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
}


@end
