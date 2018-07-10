//
//
//  XYCardInfoCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  这个Cell就是创建各个 CardInfoCell 具体类别的积基类
//  由于每个Cell中都会填写一些Card对应的信息。。
//  每个内部包含textTF的，需要长期持有其cell内部控件以获得对应行信息的,均需子类化本类
//  本类只提供创建一次性使用的cell，无需长期持有内部tf控件。如 imageCell、addNewCell 这两个

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
