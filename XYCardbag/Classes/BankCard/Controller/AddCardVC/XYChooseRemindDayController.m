//
//  XYChooseRemindDayController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/25.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYChooseRemindDayController.h"
#import "XYChooseDayCell.h"

@interface XYChooseRemindDayController ()

@property(nonatomic , strong)     NSArray *dataArray;

@end

@implementation XYChooseRemindDayController

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @"当天",
                       @"1天前",
                       @"7天前",
                       @"30天前"
                       ];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYChooseDayCell *cell = [XYChooseDayCell cellWithTableView:tableView];
    
    cell.model = self.dataArray[indexPath.row];
    
    if ([cell.model isEqualToString:self.defaultDay]) {
        cell.selected = YES;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 选中之后的 设置为Mark状态并退出
    if (self.chooseDayBlock) {
        self.chooseDayBlock(self.dataArray[indexPath.row]);
    }
}

@end
