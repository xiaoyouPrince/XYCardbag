//
//  XYSettingViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/1.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYSettingViewController.h"
#import "DataTool.h"

@interface XYSettingViewController ()

@end

@implementation XYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    [self setupContent];
    
    self.navigationItem.title = NSLocalizedString(@"设置", nil);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneClick:)];
    
}

- (void)doneClick:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - content
- (void)setupContent{
    [self setupMedium];
}
- (void)setupMedium{
    
    __weak typeof(XYSettingViewController) *weakSelf = self;
    [self setContentWithData:[DataTool settingData] itemConfig:^(XYInfomationItem * _Nonnull item) {
        if (item.title != NSLocalizedString(@"反馈", nil)) {
            item.titleWidthRate = 0.6;
        }
        item.titleFont = [UIFont boldSystemFontOfSize:16];
    } sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
    }  sectionDistance:30 contentEdgeInsets:UIEdgeInsetsMake(20, 0, 30, 0) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
        NSArray *special = @[@"Share"];
        for (NSString *str in special) { // 拦截特殊操作
            if ([cell.model.titleKey containsString:str]) {
                [weakSelf dealWithSpecialWithKey:cell.model.titleKey];
                return;
            }
        }
                
        UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
        detail.title = cell.model.title;
        [weakSelf.navigationController pushViewController:detail animated:YES];
    }];
    
    
    UILabel *versionLabel = [UILabel new];
    versionLabel.textColor = UIColor.grayColor;
    versionLabel.text = @"卡片助手: v: 1.0.0";
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self setFooterView:versionLabel];
}

/// 一个拦截方法对于需要特殊处理的函数，拦截处理
- (void)dealWithSpecialWithKey:(NSString *)key{
    
//    let act = UIActivityViewController(activityItems: ["我是要分享的内容"], applicationActivities: nil)
//    present(act, animated: true) {
//        print("presented")
//    }
    
    UIActivityViewController *act = [[UIActivityViewController alloc] initWithActivityItems:@[@"卡片助手http://www.baidu.com"] applicationActivities: nil];
    
    [self presentViewController:act animated:YES completion:^{
        
    }];
    
}


@end

#warning TODO - 设计一个 AppUtil 提供 App 相关信息的方法
// 如
// App 展示名称
// App 当前版本
