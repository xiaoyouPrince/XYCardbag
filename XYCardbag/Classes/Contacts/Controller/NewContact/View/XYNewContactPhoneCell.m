//
//  XYNewContactPhoneCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/19.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYNewContactPhoneCell.h"

@implementation XYNewContactPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString *cellID = @"XYNewContactPhoneCell";
    
    XYNewContactPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    }
    
    return cell;
}

- (void)setModel:(id)model
{
    _model = model;
    
    
}

- (CGFloat)cellHeight
{
    return _cellHeight;
}

@end
