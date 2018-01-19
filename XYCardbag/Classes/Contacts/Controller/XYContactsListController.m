//
//  XYContactsListController.m
//  XYCardbag
//
//  Created by xiaoyou on 2017/12/18.
//  Copyright © 2017年 xiaoyou. All rights reserved.
//

#import "XYContactsListController.h"
#import "XYContactsDBTool.h"
#import "XYContactsDetailController.h"
#import "XYAddNewContactController.h"


@interface XYContactsListController ()

@property(nonatomic , strong)NSMutableArray* dataArray;

@end

static NSString *cellID = @"CellID";

@implementation XYContactsListController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
//            [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];
            
            // 从数据库中加载对应的数据、
            _dataArray = [[XYContactsDBTool sharedInstance] getAllContacts];
        }
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// setuo NavBar
    [self setupNavBar];
    
    /// setup tableView
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.tableView reloadData];
}

- (void)setupNavBar
{
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [self test];
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem , [self test]];
}


- (UIBarButtonItem *)test{
    
    UIBarButtonItem *item = [UIBarButtonItem backItemWithimage:nil highImage:nil target:self action:@selector(addContact) title:@"Add"];
    return item;
}


- (void)addContact{
    XYFunc
    
//    NSString *new = [NSString stringWithFormat:@"%ld",self.dataArray.count + 1];
//    [self.dataArray addObject:new];
//    [[self tableView] reloadData];
    
    /// 进入对应的列表页面
    XYAddNewContactController *addNew = [XYAddNewContactController new];
    [self presentViewController:addNew animated:YES completion:^{
        // 重新刷新数据
        [[self tableView] reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第 %zd 个 cell",[self.dataArray[indexPath.row] integerValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYContactsDetailController *vc = [XYContactsDetailController new];
    vc.conName = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        UIAlertController *al = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除后无法恢复，是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            // Delete the row from the data source
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            
        }];
        [al addAction:action1];
        [self presentViewController:al animated:YES completion:nil];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        NSString *new = [NSString stringWithFormat:@"%ld",self.dataArray.count + 1];
        [self.dataArray addObject:new];
        [[self tableView] reloadData];
    }   
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    // 移动数据源
    NSString *from = [self.dataArray objectAtIndex:fromIndexPath.row];
    NSString *to = [self.dataArray objectAtIndex:toIndexPath.row];
    
    if (fromIndexPath.row < toIndexPath.row) { //从上到下
        [self.dataArray insertObject:from atIndex:toIndexPath.row + 1]; // 需要 + 1
        [self.dataArray removeObjectAtIndex:fromIndexPath.row];
    }else
    { // 从下到上
        [self.dataArray removeObjectAtIndex:fromIndexPath.row];
        [self.dataArray insertObject:from atIndex:toIndexPath.row];
    }
    [self.tableView reloadData];
}


@end
