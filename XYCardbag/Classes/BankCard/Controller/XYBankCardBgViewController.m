//
//
//  XYBankCardBgViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/4.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  这种页面好像不能用Masonry ?????
//  经验证，这里的如果是继承 TableViewController 就不能用Masonry 添加 subView
//        如果是继承 ViewController 能用Masonry 添加 subView
//        无论如何都可以用frame添加的方式添加


#import "XYBankCardBgViewController.h"
#import "Masonry.h"

@interface XYBankCardBgViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) UIToolbar  *toolBar;

@end

@implementation XYBankCardBgViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self buildUI];
    
    
    
    

}


- (void)buildUI{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = UIColor.clearColor;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    UIToolbar *topView = UIToolbar.new;
    topView.backgroundColor = UIColor.brownColor;
    topView.layer.borderColor = UIColor.blackColor.CGColor;
    topView.layer.borderWidth = 2;
    [self.view addSubview:topView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(self.view).offset(-44);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    
    
//    事实证明 TableView上不能添加subview，只能在容器的View上使用masonry
//    UIToolbar *subtopView = UIToolbar.new;
//    subtopView.backgroundColor = UIColor.brownColor;
//    subtopView.layer.borderColor = UIColor.blackColor.CGColor;
//    subtopView.layer.borderWidth = 2;
//    [self.tableView addSubview:subtopView];
//
//    [subtopView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tableView);
//        make.right.equalTo(self.tableView);
//        make.bottom.equalTo(self.tableView);
//        make.height.equalTo(@40);
//    }];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第 %zd 个 cell",indexPath.row];
    cell.backgroundColor = indexPath.row % 2 ? [UIColor purpleColor]: [UIColor greenColor];
    
    return cell;
}



@end
