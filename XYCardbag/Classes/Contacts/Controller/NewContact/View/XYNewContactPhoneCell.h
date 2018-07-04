//
//  XYNewContactPhoneCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/19.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYNewContactPhoneCell : UITableViewCell

@property(nonatomic , strong) id model;
@property(nonatomic , assign) CGFloat cellHeight;

+ (instancetype)cellWithTableview:(UITableView *)tableView;

@end
