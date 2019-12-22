//
//
//  XYAddCardController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/6.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  添加新卡页面

#import "XYAddCardController.h"
#import "XYAddCardDetailController.h"

@interface XYAddCardController ()
@end

@implementation XYAddCardController


#pragma mark -- life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加卡片";
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    self.xy_popGestureRatio = 0.5;
    
    // 卡片列表
    XYInfomationItem *item1 = [XYInfomationItem modelWithImage:@"wizard_normalcard" Title:@"普通卡" titleKey:@"wizard_normalcard" type:XYInfoCellTypeChoose value:@" " placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item2 = [XYInfomationItem modelWithImage:@"wizard_creditcard" Title:@"信用卡" titleKey:@"wizard_creditcard" type:XYInfoCellTypeChoose value:@" " placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item3 = [XYInfomationItem modelWithImage:@"wizard_storecard" Title:@"购物卡" titleKey:@"wizard_storecard" type:XYInfoCellTypeChoose value:@" " placeholderValue:nil disableUserAction:YES];
    
    XYInfomationSection *section = [XYInfomationSection sectionForOriginal];
    section.dataArray = @[item1,item2,item3];
    [self setHeaderView:section edgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
    
    XYWeakSelf;
    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
        if ([cell.model.title isEqualToString:@"普通卡"]) {
            /// 进入对应的列表页面
            XYAddCardDetailController *listVC = [XYAddCardDetailController new];
            listVC.sectionID = weakSelf.sectionID;
            [weakSelf.navigationController pushViewController:listVC animated:YES];
        }
        
        if ([cell.model.title isEqualToString:@"信用卡"]) {
            /// 进入对应的列表页面
            XYAddCardDetailController *listVC = [XYAddCardDetailController new];
            listVC.sectionID = weakSelf.sectionID;
            [weakSelf.navigationController pushViewController:listVC animated:YES];
        }
        
        if ([cell.model.title isEqualToString:@"购物卡"]) {
            /// 进入对应的列表页面
            XYAddCardDetailController *listVC = [XYAddCardDetailController new];
            listVC.sectionID = weakSelf.sectionID;
            [weakSelf.navigationController pushViewController:listVC animated:YES];
        }
    };
}

@end
