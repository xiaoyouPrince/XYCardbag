//
//  XYAddNewCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/19.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYAddNewCell.h"

@implementation XYAddNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableview:(UITableView *)tableView title:(NSString *)title
{
    static NSString *cellID = @"addNewCell";
    
    XYAddNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[XYAddNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = title;
    
    return cell;
}

@end
