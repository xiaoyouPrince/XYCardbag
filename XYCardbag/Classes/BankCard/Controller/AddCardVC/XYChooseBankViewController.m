//
//  XYChooseBankViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/10.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYChooseBankViewController.h"
#import "DataTool.h"
#import "XYAddCardDetailController.h"
#import <XYKit/UIImage+XYAdd.h>

@interface XYChooseBankViewController ()

@end

@implementation XYChooseBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBgColor;
    self.title = NSLocalizedString(@"选择银行", nil);
    self.xy_popGestureRatio = 0.5;
    
    // 设置银行列表
    XYWeakSelf
    [self setContentWithData:[DataTool chooseBankData] itemConfig:nil sectionConfig:nil sectionDistance:0 contentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
//        UIImage *image = [UIImage imageNamed:cell.model.imageName];
        
//        NSArray *colors = (NSArray *)cell.model.obj;
//        NSMutableArray *colorsM = @[].mutableCopy;
//        for (NSString *colorStr in colors) {
//            NSArray *component = [colorStr componentsSeparatedByString:@","];
//            CGFloat r = [component[0] integerValue];
//            CGFloat g = [component[1] integerValue];
//            CGFloat b = [component[2] integerValue];
//            UIColor *c = XYColor(r, g, b);
//            [colorsM addObject:c];
//        }
//        [cell xy_setGradientColors:colorsM];
        
        
        
        XYAddCardDetailController *listVC = [XYAddCardDetailController new];
        listVC.sectionID = weakSelf.sectionID;
        listVC.cardType = weakSelf.cardType;
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    }];
}

@end
