//
//  XYAddNewContactController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/19.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYAddNewContactController.h"
#import "XYContacts.h"
#import "XYNewContactInfoCell.h"
#import "XYNewContactPhoneCell.h"
#import "XYAddNewCell.h"
#import "XYContactsDBTool.h"

#import "XYContactsDetailController.h"

@interface XYAddNewContactController ()

@property(nonatomic , strong) UIBarButtonItem  *rightItem;


/// dataArray


/// 新建联系人的model
@property(nonatomic , strong) XYContacts  *contact;

///

@end

@implementation XYAddNewContactController

- (XYContacts *)contact
{
    if (_contact == nil) {
        _contact = [XYContacts new];
    }
    return _contact;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// navbar
    [self setupNavBar];
    
    /// tableView
    [self setupTableView];
    
}

- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = self.leftItem;
    self.title = @"New Contact";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setupTableView
{
    self.tableView.editing = YES;
    
    self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    self.rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.rightItem;

    /// 系统监听
    [kNotificationCenter addObserver:self selector:@selector(systemTextFieldObserver) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)rightItemClick{
 
    XYFunc
    // 用户点击完成并返回。
    
    // 1.保存数据
    self.contact = [XYContacts new];
    self.contact.name = @"xiaoyou";
    self.contact.phoneNum = @"15270937293";
    self.contact.email = @"xiaoyou@183.com";
    
//    [[XYContactsDBTool sharedInstance] addContact:@"xiaoyou" phoneNum:@"15270937293" email:@"xiaoyou@183.com"];
    [[XYContactsDBTool sharedInstance] addContact:self.contact];
    
    
    // 2.首页刷新数据
    
    [self dismissViewControllerAnimated:YES completion:^{
        // 发通知刷新页面
        [kNotificationCenter postNotificationName:@"refreshDetailViewControllor" object:nil];
        // 发通知刷新列表页面
        [kNotificationCenter postNotificationName:@"refreshListViewControllor" object:nil];
    }];
}


- (void)systemTextFieldObserver
{
    
    self.rightItem.enabled = YES;
//    self.editButtonItem.enabled = YES;
}

- (UIBarButtonItem *)leftItem{
    
    UIBarButtonItem *item = [UIBarButtonItem xy_itemWithTarget:self action:@selector(cancelAndDissmiss) title:@"cancel"];
    return item;
}

- (void)cancelAndDissmiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneAndPopToDetail
{
    // 这里是完成了并退出

    /// dismiss添加页面
    [self dismissViewControllerAnimated:YES completion:^{
        // 发通知刷新页面
        [kNotificationCenter postNotificationName:@"refreshDetailViewControllor" object:nil];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // 目前共分四组
    // 第一组，头像和基本信息cell
    // 第二组，phoneNum
    // 第三组, email
    // 第四组，地址
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0) return 1;
    if (section == 1) return 1;
    if (section == 2) return 1;
    if (section == 3) return 1;
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 头像和基本信息
        return [self configInfoCell];
        
    }
    
    NSInteger section2Count = [tableView numberOfRowsInSection:1];
    if (indexPath.section == 1 && indexPath.row == section2Count-1) {
        // 添加电话信息
        return [self configPhoneCell];
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 头像和基本信息
        return [self configInfoCell];
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 头像和基本信息
        return [self configInfoCell];
        
    }
    
    return [UITableViewCell new];
}

/// 头像和基本信息cell
- (UITableViewCell *)configInfoCell
{
    XYNewContactInfoCell *cell = [XYNewContactInfoCell cellWithTableview:self.tableView];
    
    cell.block = ^(BOOL canEidt) {
        self.editButtonItem.enabled = canEidt;
    };
    
    //    cell.model = @"";
    
    return cell;
}


- (UITableViewCell *)configPhoneCell
{
//    XYNewContactPhoneCell *cell = [XYNewContactPhoneCell cellWithTableview:self.tableView];
//
//    return cell;
    
    XYAddNewCell *cell = [XYAddNewCell cellWithTableview:self.tableView title:@"add Phone"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if ([cell isKindOfClass:[XYNewContactInfoCell class]]) {
//        XYNewContactInfoCell *infocell = (XYNewContactInfoCell *)cell;
//        return infocell.cellHeight;
//    }
    
    if (indexPath.row == 0) {
        return 140;
    }
    
    if (indexPath.section == 1) {
        return 60;
    }
    
    return 60;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {return NO;}
    
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSInteger section1Count = [tableView numberOfRowsInSection:1];
    NSInteger section2Count = [tableView numberOfRowsInSection:2];
//    NSInteger section3Count = [tableView numberOfRowsInSection:3];

    if (indexPath.section == 1 && indexPath.row == section1Count-1) {
        return UITableViewCellEditingStyleInsert;
    }else if (indexPath.section == 2 && indexPath.row == section2Count-1){
        return UITableViewCellEditingStyleInsert;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
    

    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        if (indexPath.section == 1) {
            // [self configPhoneCell];
            
            
            // 添加对应的数据,这里是添加phoneCell
            // 修改数据源，刷新列表
            
        }
    }   
}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)dealloc
{
    // 移除监听
    [kNotificationCenter removeObserver:self];
}

@end
