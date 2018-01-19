//
//  XYContactDetailCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/18.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYContactDetailCell.h"

@interface XYContactDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation XYContactDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString *cellID = @"contactDetail";
    
    XYContactDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    }
    
    return cell;
}

- (void)setModel:(XYContacts *)model
{
    _model = model;
    
    
}

@end
