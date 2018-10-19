//
//  XYAddCustomTagCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/19.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYAddCustomTagCell.h"

NSString *const DidChooseCustomTagNotification = @"DidChooseCustomTagNotification";

@interface XYAddCustomTagCell()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *customTitleTF;
@property (weak, nonatomic) IBOutlet UILabel *chooseTagLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *tagPicker;
@property(nonatomic , strong)     NSMutableArray *dataArray;

@end

@implementation XYAddCustomTagCell

- (NSArray *)dataArray
{
    if (!_dataArray) {
        
        NSArray *firstSection = @[@"日期",
                                  @"电话",
                                  @"邮件",
                                  @"网址",
                                  @"其他"];
        
        _dataArray = @[].mutableCopy;
        [_dataArray addObject:firstSection];
    }
    return _dataArray;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *const customTagCellID = @"customTagCellID";
    XYAddCustomTagCell *cell = [tableview dequeueReusableCellWithIdentifier:customTagCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 1. 基础设置 topView
    NSString *defaultTagSting = @"其他";
    [self.customTitleTF becomeFirstResponder];
    self.chooseTagLabel.text = defaultTagSting;
    _customCardnfo = [XYCardInfoModel cardinfoWithTagString:defaultTagSting];
    [kNotificationCenter addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:self.customTitleTF];
    
    // 2. 基础设置 picker
    self.tagPicker.delegate = self;
    self.tagPicker.dataSource = self;
    NSArray *firstComponent = self.dataArray[0];
    [self.tagPicker selectRow:firstComponent.count - 1 inComponent:0 animated:YES]; // 默认选中最后一个【其他】
    
    _cellHeight = 154;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *componentArray = self.dataArray[component];
    return componentArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *componentArray = self.dataArray[component];
    return componentArray[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 选中了对应的分组，修改并记录用户设置
    NSArray *componentArray = self.dataArray[component];
    NSString *choosenTagTitle = componentArray[row];
    
    self.chooseTagLabel.text = choosenTagTitle;
    
    
    // 这里可以监听，修改最新的tagType
    self.customCardnfo.tagType = [XYCardInfoModel tagTypeWithTagString:choosenTagTitle];
    
    // 只要每次选中都把对应的model发给外部。
    //[kNotificationCenter postNotificationName:DidChooseCustomTagNotification object:cardInfo];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldTextChanged:(NSNotification *)noti{
    
    UITextField *tf = noti.object;
    
    // 监听到最新的文字，设置cardInfo 的title
    self.customCardnfo.title = tf.text;
}


- (void)dealloc{
    
    [kNotificationCenter removeObserver:self];
}

@end
