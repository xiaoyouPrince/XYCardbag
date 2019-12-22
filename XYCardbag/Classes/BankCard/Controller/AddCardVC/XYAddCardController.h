//
//
//  XYAddCardController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/6.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  添加卡片

#import <UIKit/UIKit.h>
#import <XYInfomationBaseViewController.h>

@interface XYAddCardController : XYInfomationBaseViewController

/**
 要保存卡片的sectionID。对应的那个大类
 */
@property(nonatomic , copy) NSNumber * sectionID;

@end
