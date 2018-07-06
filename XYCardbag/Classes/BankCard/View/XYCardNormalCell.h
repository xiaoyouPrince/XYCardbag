//
//
//  XYCardNormalCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/6.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYBankCardModel.h"

@interface XYCardNormalCell : UITableViewCell

@property(nonatomic , strong) XYBankCardModel  *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
