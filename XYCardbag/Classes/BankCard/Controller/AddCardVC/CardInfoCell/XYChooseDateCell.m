//
//  XYChooseDateCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/25.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYChooseDateCell.h"

@interface XYChooseDateCell ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation XYChooseDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDefaultDate:(NSDate *)defaultDate
{
    _defaultDate = defaultDate;
    
    if(defaultDate) {
        [self.datePicker setDate:self.defaultDate animated:YES];
    }
}

- (NSDate *)choosenDate
{
    return self.datePicker.date;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *const chooseDateCellID = @"chooseDateCellID";
    XYChooseDateCell *cell = [tableview dequeueReusableCellWithIdentifier:chooseDateCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    }
    return cell;
}

@end
