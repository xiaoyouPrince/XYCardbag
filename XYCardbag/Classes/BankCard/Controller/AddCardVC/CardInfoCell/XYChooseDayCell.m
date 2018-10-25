//
//  XYChooseDayCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/25.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYChooseDayCell.h"

@implementation XYChooseDayCell

static NSString *unChooseName = @"unChooseName";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [kNotificationCenter addObserver:self selector:@selector(changeSelection:) name:unChooseName object:nil];
}

- (void)changeSelection:(NSNotification *)noti{
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.isSelected) {
        [kNotificationCenter postNotificationName:unChooseName object:nil];
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}





/**
 快速创建一个选择自定义tag的Cell
 
 @param tableview 源tableview
 @return cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *cellID = @"chooseDayCell";
    XYChooseDayCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    }
    
    return cell;
}

- (void)setModel:(NSString *)model
{
    _model = model;
    
    self.textLabel.text = model;
}



@end
