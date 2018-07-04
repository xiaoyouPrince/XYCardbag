//
//  XYNewContactInfoCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/19.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYNewContactInfoCell.h"

@interface XYNewContactInfoCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *companyTF;

@end

@implementation XYNewContactInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImage.layer.cornerRadius = 25;
    self.iconImage.clipsToBounds = YES;
    
    self.lastNameTF.delegate = self;
    
    // default height = 140
    _cellHeight = 140;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.block(textField.text.length ? YES : NO);

    // 回传，让edit可以点击
    if (self.block) {
        self.block(textField.text.length ? YES : NO);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString *cellID = @"XYNewContactInfoCell";
    
    XYNewContactInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
