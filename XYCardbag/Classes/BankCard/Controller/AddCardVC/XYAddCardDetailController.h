//
//
//  XYAddCardDetailController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XYAddCardDetailController : UITableViewController


/**
 添加卡的类型,内部根据卡片类型进行不同UI的渲染
 */
@property(nonatomic , assign) CardType cardType;
/**
 要保存卡片的sectionID。对应的那个大类
 */
@property(nonatomic , copy) NSNumber * sectionID;

@end
