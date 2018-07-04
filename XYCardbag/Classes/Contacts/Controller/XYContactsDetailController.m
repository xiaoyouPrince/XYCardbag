//
//  XYContactsDetailController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/18.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYContactsDetailController.h"
#import "XYAddNewContactController.h"

@interface XYContactsDetailController ()

@end

@implementation XYContactsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.conName;
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem backItemWithimage:nil highImage:nil target:self action:@selector(changeViewToEidt) title:@"Edit"];
    
    
    if (self.isAddNew) {
        /// 进入对应的列表页面
        XYAddNewContactController *addNew = [XYAddNewContactController new];
        [self.navigationController pushViewController:addNew animated:NO];
//        [self presentViewController:addNew animated:YES completion:nil];
    }
    
    /// 注册通知
    [kNotificationCenter addObserver:self selector:@selector(refreshDetailView) name:@"refreshDetailViewControllor" object:nil];
}

- (void)changeViewToEidt
{
    DLog(@" ----- 进入编辑页面 -----");
    /// 进入对应的列表页面
    XYAddNewContactController *addNew = [XYAddNewContactController new];
    [self.navigationController pushViewController:addNew animated:NO];
}

- (void)refreshDetailView
{
    DLog(@" ----- 刷新本页面 -----");
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellIDtemp";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@" ----- %zd ---- ",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 目前不做任何操作
}



@end
