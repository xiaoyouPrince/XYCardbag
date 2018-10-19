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

@interface XYAddNewCardTagController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic , strong)     NSMutableArray *dataArray;

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
    
    // 测试添加一个model
    XYCardInfoModel *model = [XYCardInfoModel new];
    model.tagType = TagTypeBaseName;
    if (self.addTagBlock) {
        self.addTagBlock(model);
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
    if (indexPath.section == 0) {
        
        static NSString *const tagCellID = @"chooseTagCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tagCellID];
        }
        
        NSArray *section = self.dataArray[indexPath.section];
        cell.textLabel.text = section[indexPath.row];
        return cell;
    }
    
    // 第二组返回一个自定义的选择custom tag的cell
    static NSString *const customTagCellID = @"customTagCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customTagCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTagCellID];
    }
    
    NSArray *section = self.dataArray[indexPath.section];
    cell.textLabel.text = section[indexPath.row];
    return cell;
    
}



@end
