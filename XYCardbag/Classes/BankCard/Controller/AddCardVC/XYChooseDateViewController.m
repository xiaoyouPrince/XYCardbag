//
//  XYChooseDateViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/25.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYChooseDateViewController.h"
#import "XYCardInfoModel.h"
#import "XYChooseDateCell.h"
#import "XYChooseRemindDayController.h"

static NSString *const ChooseDateKeyOpenRemind = @"启用通知";
static NSString *const ChooseDateKeyOpenRemindMonthly = @"每月重复提醒";
static NSString *const ChooseDateKeyRemindDate = @"提醒日期";

@interface XYChooseDateViewController ()

@property(nonatomic , strong)     NSMutableArray *dataArray;

@end

@implementation XYChooseDateViewController
{
    XYChooseDateCell *_chooseDateCell;
}

- (void)setTag:(XYCardInfoModel *)tag
{
    _tag = tag;
    _dataArray = @[].mutableCopy;
    // sectionOne
    [_dataArray addObject:@[@"chooseDateSection"]];
    
    if (!tag.remind) {
        
        // sectionTwo
        NSMutableArray *sectionTwo = [NSMutableArray array];
        [sectionTwo addObject:@{ChooseDateKeyOpenRemind : @(NO)}.mutableCopy];
        [sectionTwo addObject:@{ChooseDateKeyOpenRemindMonthly : @(NO)}.mutableCopy];
        [sectionTwo addObject:@{ChooseDateKeyRemindDate : @"当天"}.mutableCopy];
        [_dataArray addObject:sectionTwo];
    }else{
        
        // sectionTwo
        NSMutableArray *sectionTwo = [NSMutableArray array];
        [sectionTwo addObject:@{ChooseDateKeyOpenRemind : @(tag.remind.remind)}.mutableCopy];
        [sectionTwo addObject:@{ChooseDateKeyOpenRemindMonthly : @(tag.remind.remindEveryMonth)}.mutableCopy];
        [sectionTwo addObject:@{ChooseDateKeyRemindDate : tag.remind.remindBeforeDays}.mutableCopy];
        [_dataArray addObject:sectionTwo];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 第一组时间选择
    // 第二组选择是否开启提醒
    self.title = self.tag.title;
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    //
    NSArray *sectionTwo = self.dataArray.lastObject;
    NSDictionary *remindDict = sectionTwo[0];
    NSDictionary *remindMonthDict = sectionTwo[1];
    NSDictionary *remindDayDict = sectionTwo[2];
    
    XYRemind *remind = self.tag.remind;
    if (!remind) {
        remind = [[XYRemind alloc] init];
    }
    
    remind.remindDate = _chooseDateCell.choosenDate;
    remind.remind = [remindDict[ChooseDateKeyOpenRemind] boolValue];
    remind.remindEveryMonth = [remindMonthDict[ChooseDateKeyOpenRemindMonthly] boolValue];
    remind.remindBeforeDays = remindDayDict[ChooseDateKeyRemindDate];
    
    self.tag.remind = remind;
    
    // 更新相关参数
    if (self.chooseDateBlock) {
        self.chooseDateBlock(remind);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sectionArr = self.dataArray[section];
    
    if (section == 0) {
        return sectionArr.count;
    }
    
    NSDictionary *dict = sectionArr.firstObject;
    BOOL openRmind = [dict[ChooseDateKeyOpenRemind] boolValue];
    if (openRmind) {
        return sectionArr.count;
    }else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 200;
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == self.dataArray.count-1) {
        return 20;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"ChooseDateCellID";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) { // 第一组选择时间picker
        XYChooseDateCell *  cell = [XYChooseDateCell cellWithTableView:tableView];
        cell.defaultDate = self.tag.remind.remindDate;
        _chooseDateCell = cell;
        return cell;
    }
    
    NSArray *sectionArr = self.dataArray[indexPath.section];
    NSDictionary *rowDict = sectionArr[indexPath.row];
    if (indexPath.row == sectionArr.count-1) { // 最后一组选择提醒日期
        
//        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//        }
        
        NSDictionary *dict = sectionArr.lastObject;
        cell.textLabel.text = ChooseDateKeyRemindDate;
        cell.detailTextLabel.text = dict[ChooseDateKeyRemindDate];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = nil;
        return cell;
    }
    
    // 剩下的就是选择是否开启通知，和开启每月通知
//    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
    if (indexPath.row == 0) { // 开启提醒
        
        cell.textLabel.text = ChooseDateKeyOpenRemind;
        cell.detailTextLabel.text = nil;
        
        UISwitch *openRemindSwitch = [UISwitch new];
        openRemindSwitch.on = [rowDict[ChooseDateKeyOpenRemind] boolValue];
        [openRemindSwitch addTarget:self action:@selector(openRemind:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = openRemindSwitch;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else{ // 开启每月提醒
        
        cell.textLabel.text = ChooseDateKeyOpenRemindMonthly;
        cell.detailTextLabel.text = nil;
        
        UISwitch *openRemindSwitch = [UISwitch new];
        openRemindSwitch.on = [rowDict[ChooseDateKeyOpenRemindMonthly] boolValue];
        [openRemindSwitch addTarget:self action:@selector(openRemindMonthly:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = openRemindSwitch;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (void)openRemind:(UISwitch *)sender{
    
    // 修改状态 && 数据 && 更新UI
    
    BOOL isON = sender.isOn;
    if (isON) { // 开启通知
        
        [self openRemind];
        
    }else
    {   // 禁用通知
        [self closeRemind];
    }
    
    
}

- (void)openRemind{
    
    NSMutableArray *array = self.dataArray.lastObject;
    
    NSDictionary *dict = array.firstObject;
    [dict setValue:@(YES) forKey:ChooseDateKeyOpenRemind];
    
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)closeRemind{
    
    NSMutableArray *array = self.dataArray.lastObject;
    
    NSDictionary *dict = array.firstObject;
    [dict setValue:@(NO) forKey:ChooseDateKeyOpenRemind];
    
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

- (void)openRemindMonthly:(UISwitch *)sender{
    
    // 修改状态 && 数据 && 更新UI [无需reloadData]
    
    BOOL isON = sender.isOn;
    if (isON) { // 开启通知
        
        [self openRemindMonthly];
        
    }else
    {   // 禁用通知
        [self closeRemindMonthly];
    }
}

- (void)openRemindMonthly{
    
    NSMutableArray *array = self.dataArray.lastObject;
    
    NSDictionary *dict = array[1];
    [dict setValue:@(YES) forKey:ChooseDateKeyOpenRemindMonthly];
}

- (void)closeRemindMonthly{
    
    NSMutableArray *array = self.dataArray.lastObject;
    
    NSDictionary *dict = array[1];
    [dict setValue:@(NO) forKey:ChooseDateKeyOpenRemindMonthly];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == self.dataArray.count-1) { // 选择日期(the last row)
        NSArray * lastSection = self.dataArray[indexPath.section];
        if (indexPath.row == lastSection.count-1) {
            
            NSDictionary *dict = lastSection.lastObject;
            
            // 选择提醒日期
            XYChooseRemindDayController *chooseDay = [XYChooseRemindDayController new];
            chooseDay.title = ChooseDateKeyRemindDate;
            chooseDay.defaultDay = dict[ChooseDateKeyRemindDate];
            chooseDay.chooseDayBlock = ^(NSString *result){
                // 选择日期
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = result;
                
                [dict setValue:result forKey:ChooseDateKeyRemindDate];
            };
            [self.navigationController pushViewController:chooseDay animated:YES];
        }
    }
}


@end
