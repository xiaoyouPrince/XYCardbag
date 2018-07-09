//
//
//  XYAddCardDetailController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
/*
 
 这是一个tableview展示要添加的各种卡片信息
 
 主要有卡片图片 && 卡片信息
 
 卡片图片：
    一个单独的cell
 卡片信息：
    基本信息：名称 + 卡号 + 备注
    更多卡片信息：共5种类型：日期(提供picker快速选日期功能) + 电话 + 邮件 + 网址 + 其他(后四种主要是键盘不同)  ？？？ 是否可用继承的方式做？
 
 */

#import "XYAddCardDetailController.h"
#import "XYCardInfoCell.h"
#import "XYAddNewCardTagController.h"

@interface XYAddCardDetailController ()

// 包含所有本页面中cardInfoModel
@property(nonatomic , strong) NSMutableArray  *dataArray;
@property(nonatomic , strong) UIView  *headerOne;
@property(nonatomic , strong) UIView  *headerTwo;


@end

@implementation XYAddCardDetailController

- (UIView *)headerOne
{
    if (_headerOne == nil) {
        _headerOne = [UIView new];
        UILabel *label = [UILabel new];
        label.font = [UIFont boldSystemFontOfSize:15];
        label.text = @"卡片图片";
        label.textColor = [UIColor cyanColor];
        [_headerOne addSubview:label];
        label.frame = CGRectMake(0, 0, ScreenW, 30);
        label.xy_x += 20;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        line.frame = CGRectMake(0, 29.5, ScreenW, 0.5);
        [_headerOne addSubview:line];
        _headerOne.backgroundColor = UIColor.whiteColor;
    }
    return _headerOne;
}
- (UIView *)headerTwo
{
    if (_headerTwo == nil) {
        _headerTwo = [UIView new];
        UILabel *label = [UILabel new];
        label.font = [UIFont boldSystemFontOfSize:15];
        label.text = @"卡片信息";
        label.textColor = [UIColor cyanColor];
        [_headerTwo addSubview:label];
        label.frame = CGRectMake(0, 0, ScreenW, 30);
        label.xy_x += 20;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        line.frame = CGRectMake(0, 29.5, ScreenW, 0.5);
        [_headerTwo addSubview:line];
        _headerTwo.backgroundColor = UIColor.whiteColor;
    }
    return _headerTwo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建对应的data数据
    XYCardInfoModel *imageInfo = [XYCardInfoModel new];
    imageInfo.tagType = TagTypeBaseImage;
    
    XYCardInfoModel *nameInfo = [XYCardInfoModel new];
    nameInfo.tagType = TagTypeBaseName;
    
    XYCardInfoModel *numberInfo = [XYCardInfoModel new];
    numberInfo.tagType = TagTypeBaseNumber;
    
    XYCardInfoModel *descInfo = [XYCardInfoModel new];
    descInfo.tagType = TagTypeBaseDesc;
    
    self.dataArray = [NSMutableArray array];
    NSMutableArray *sectionTwo = [NSMutableArray arrayWithObjects:nameInfo,numberInfo,descInfo, nil];
    [self.dataArray addObjectsFromArray:@[@[imageInfo],sectionTwo]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    NSArray *infoSection = self.dataArray[section];
    return infoSection.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }
    else //if (indexPath.section == 1)
    {
        if (indexPath.row == 2) { // 第三个cell。描述信息的cell
            return 100;
        }
        
        return 50; // 正常cell都是50
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.headerOne;
        
    }else //if (section == 1)
    {
        return self.headerTwo;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sectionArr = self.dataArray[indexPath.section];
    XYCardInfoModel *cardInfo;
    if (indexPath.row != sectionArr.count){
        cardInfo = sectionArr[indexPath.row];
    }
    
    if (indexPath.section == 0) {
        XYCardInfoCell *cell = [XYCardInfoCell cellForCardImagesWithTableView:tableView];
        cell.model = cardInfo;
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {   // name
            XYCardInfoCell *cell = [XYCardInfoCell cellForCardNameWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
        
        if (indexPath.row == 1) {   // number
            XYCardInfoCell *cell = [XYCardInfoCell cellForCardNumberWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
        
        if (indexPath.row == 2) {   // desc
            XYCardInfoCell *cell = [XYCardInfoCell cellForCardDescWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
        
        NSArray *infoSection = self.dataArray[indexPath.section];
        if (indexPath.row == infoSection.count) {  // 添加新类别的cell
            XYCardInfoCell *cell = [XYCardInfoCell cellForAddNewWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
    }
    
    // 其余的都是用户可以自己添加的
    XYCardInfoCell *cell = [XYCardInfoCell cellForCardImagesWithTableView:tableView];
    cell.model = cardInfo;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *infoSection = self.dataArray[indexPath.section];
    if (indexPath.row == infoSection.count) {
        
        // 最后一个cell点击进入，选择添加类别的页面,通过block回传添加的tag并放到自己打data中。 -- 当本页显示的时候再刷新
        /// 进入对应的列表页面
        XYAddNewCardTagController *listVC = [XYAddNewCardTagController new];
        [self.navigationController pushViewController:listVC animated:YES];
        listVC.addTagBlock = ^(XYCardInfoModel *model) {
            // 拿到添加的tag的modle . 添加到self.dataArray 中的第二组(最后一组)

            NSMutableArray *sectionTwo = self.dataArray[self.dataArray.count - 1];
            [sectionTwo addObject:model];
            
            [self.tableView reloadData];
            
#warning mark -- 这里可以进行性能优化，只刷新最后一行
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sectionTwo.count inSection:1];
//            [self.tableView reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationFade];
        };
    }
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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

@end
