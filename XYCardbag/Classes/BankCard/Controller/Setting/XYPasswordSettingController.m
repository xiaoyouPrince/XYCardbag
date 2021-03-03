//
//  XYPasswordSettingController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/2.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYPasswordSettingController.h"
#import "DataTool.h"

@interface XYPasswordSettingController ()

@end

@implementation XYPasswordSettingController{
    BOOL shouldFlushDataWhenViewWillAppear;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    [self setupContent];
    
    UIImage *backImage = [UIImage imageNamed:@"navigationButtonReturnClick"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem xy_itemWithTarget:self action:@selector(doneClick:) image:backImage imageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    [kNotificationCenter addObserver:self selector:@selector(setupContent) name:SettingKey_TouchID object:nil];
    [kNotificationCenter addObserver:self selector:@selector(setupContent) name:SettingKey_EnablePassword object:nil];
    [kNotificationCenter addObserver:self selector:@selector(setupNeedPwdTimeInterval) name:SettingKey_NeedPwdTimeInterval object:nil];
    
}

- (void)setupNeedPwdTimeInterval{
    shouldFlushDataWhenViewWillAppear = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (shouldFlushDataWhenViewWillAppear) {
        [self setupContent];
        shouldFlushDataWhenViewWillAppear = NO;
    }
}

- (void)doneClick:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - content
- (void)setupContent{
    [self setupMedium];
}
- (void)setupMedium{
    
    XYWeakSelf
    [self setContentWithData:[DataTool settingPasswordData] itemConfig:^(XYInfomationItem * _Nonnull item) {
        item.titleWidthRate = 0.6;
        item.titleFont = [UIFont boldSystemFontOfSize:16];
    } sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
    }  sectionDistance:30 contentEdgeInsets:UIEdgeInsetsMake(20, 0, 30, 0) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
        detail.title = cell.model.title;
        [weakSelf.navigationController pushViewController:detail animated:YES];
    }];
}
@end
