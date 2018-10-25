//
//  XYChooseDateCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/25.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYChooseDateCell : UITableViewCell
/**
 设置默认时间
 */
@property(nonatomic , copy)     NSDate *defaultDate;
/**
 选择的时间
 */
@property(nonatomic , copy , readonly)     NSDate *choosenDate;

/**
 快速创建一个选择自定义tag的Cell
 
 @param tableview 源tableview
 @return cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableview;



@end

NS_ASSUME_NONNULL_END
