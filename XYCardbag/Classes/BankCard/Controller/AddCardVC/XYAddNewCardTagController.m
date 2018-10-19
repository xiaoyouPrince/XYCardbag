//
//
//  XYAddNewCardTagController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  添加新的卡片标签

#import "XYAddNewCardTagController.h"
#import "XYAddCustomTagCell.h"

@interface XYAddNewCardTagController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic , strong)     NSMutableArray *dataArray;


/**用户选中了添加自定义tag。 default is NO*/
@property(nonatomic , assign)     BOOL didSelectedCustomCell;

@end

@implementation XYAddNewCardTagController

#pragma mark - lazy load
- (NSArray *)dataArray
{
    if (!_dataArray) {
        
        NSArray *firstSection = @[@"有效日期",
                                  @"还款日期",
                                  @"电话",
                                  @"邮件",
                                  @"网址",
                                  @"CVV/CVC"];
        
        NSArray *secondSection = @[@"choose custom tag"];
        
        _dataArray = @[].mutableCopy;
        
        
        [_dataArray addObject:firstSection];
        [_dataArray addObject:secondSection];
    }
    return _dataArray;
}

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"标签";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    // 测试添加一个model
//    XYCardInfoModel *model = [XYCardInfoModel new];
//    model.tagType = TagTypeBaseName;
//    if (self.addTagBlock) {
//        self.addTagBlock(model);
//    }
    
    if (self.didSelectedCustomCell) { // 用户自己选择了自定义tag
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        XYAddCustomTagCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        XYCardInfoModel *cardInfo = cell.customCardnfo;
        
        if (!cardInfo.title.length) return; // 没有设置title 直接返回
        
        if (self.addTagBlock) {
            self.addTagBlock(cardInfo);
        }
    }
    
    
}


#pragma tableView delegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *currentSection = self.dataArray[section];
    return currentSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *const tagCellID = @"chooseTagCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagCellID];
    }
    
    
    if (indexPath.section == 0) {
        NSArray *section = self.dataArray[indexPath.section];
        cell.textLabel.text = section[indexPath.row];
        return cell;
    }
    
    // 第二组返回一个自定义的选择custom tag的cell
    if (self.didSelectedCustomCell){
        
//        static NSString *const customTagCellID = @"customTagCellID";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customTagCellID];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTagCellID];
//        }
//
//        NSArray *section = self.dataArray[indexPath.section];
//        cell.textLabel.text = section[indexPath.row];
//        return cell;
        
        XYAddCustomTagCell *cell = [XYAddCustomTagCell cellWithTableView:tableView];
        return cell;
        
    }else // 默认可供用户选择的customCellTag
    {
        NSArray *section = self.dataArray[indexPath.section];
        cell.textLabel.text = section[indexPath.row];
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) { // 选中系统默认，直接返回
        
        // 测试添加一个model
        XYCardInfoModel *model = [XYCardInfoModel new];
        NSArray *firstArray = self.dataArray[indexPath.section];
        NSString *title = firstArray[indexPath.row];
        model.title = title;
        
        switch (indexPath.row) {
            case 0:
            case 1:
            {
                model.tagType = TagTypeDate;
            }
                break;
            case 2:
            {
                model.tagType = TagTypePhoneNumber;
            }
                break;
            case 3:
            {
                model.tagType = TagTypeMail;
            }
                break;
            case 4:
            {
                model.tagType = TagTypeNetAddress;
            }
                break;
            case 5:
            {
                model.tagType = TagTypeCustom;
            }
                break;
                
            default:
                break;
        }
        
        if (self.addTagBlock) {
            self.addTagBlock(model);
        }
        
        // 此时 didSelectedCustomCell 设置为NO
        self.didSelectedCustomCell = NO;
        
        // pop
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (indexPath.section == (self.dataArray.count - 1)){ // 最后一组
        if (!self.didSelectedCustomCell) { // 未选中过自定义
            self.didSelectedCustomCell = YES;
            NSIndexSet *sets = [[NSIndexSet alloc] initWithIndex:1];
            [self.tableView reloadSections:sets withRowAnimation:UITableViewRowAnimationAutomatic];
        }else
        {
            // nothing
        }
    }
}


@end
