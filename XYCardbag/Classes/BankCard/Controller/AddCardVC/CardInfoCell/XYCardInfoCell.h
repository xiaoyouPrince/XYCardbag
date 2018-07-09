//
//
//  XYCardInfoCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYCardInfoModel.h"

@interface XYCardInfoCell : UITableViewCell

@property(nonatomic , strong) XYCardInfoModel  *model;

/// 创建传卡片图片的cell
+ (instancetype)cellForCardImagesWithTableView:(UITableView *)tableView;

/// 创建传卡片名称的cell
+ (instancetype)cellForCardNameWithTableView:(UITableView *)tableView;

/// 创建传卡片卡号的cell
+ (instancetype)cellForCardNumberWithTableView:(UITableView *)tableView;

/// 创建传卡片描述的cell
+ (instancetype)cellForCardDescWithTableView:(UITableView *)tableView;

/// 创建传卡片自定义信息的cell - [需根据对应的model，根据具体自定义类型创建对应UI]
+ (instancetype)cellForCardInfoWithTableView:(UITableView *)tableView model:(XYCardInfoModel *)model;

/// 创建添加的更多卡片信息的cell
+ (instancetype)cellForAddNewWithTableView:(UITableView *)tableView;


@end
