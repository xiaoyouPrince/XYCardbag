//
//  XYContactDetailCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/18.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYContacts;

@interface XYContactDetailCell : UITableViewCell

@property(nonatomic , strong) XYContacts  *model;

+ (instancetype)cellWithTableview:(UITableView *)tableView;

@end
