//
//  XYBankCardController.m
//  XYCardbag
//
//  Created by xiaoyou on 2017/12/18.
//  Copyright © 2017年 xiaoyou. All rights reserved.
//
//

#define slipeWidth 200

#import "XYBankCardController.h"
#import "XYBankCardBgViewController.h"
#import "Masonry.h"
#import "XYToolBar.h"
#import "XYBankCardCache.h"
#import "XYCardNormalCell.h"
#import "XYAddCardController.h"
#import "XYBankCardDetailController.h"
#import "XYSettingViewController.h"

@interface XYBankCardController ()<BankCardBgVCDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UIView *frontView;
@property(nonatomic,weak) UIView *backView;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) XYToolBar  *toolBar;
@property(nonatomic , strong) NSMutableArray  *dataArray;
@property(nonatomic , strong) UIButton *coverView;


/**
 本页面所展示组的sectionID
 */
@property(nonatomic , copy) NSNumber * sectionID;


@end

@implementation XYBankCardController
{
    UILabel *_tableHeaderView; // will change name in the future
    UIView *_emptyView; // 没有卡片页面
}

- (UIButton *)coverView
{
    if (!_coverView) {
        _coverView = [[UIButton alloc] initWithFrame:self.view.bounds];
        _coverView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        _coverView.layer.shadowOffset = CGSizeMake(-10, 0);
        _coverView.layer.shadowOpacity = 1.0;
        _coverView.layer.shadowColor = [[UIColor whiteColor] CGColor];
        _coverView.layer.shadowRadius = 5;
        _coverView.layer.borderWidth = 0;
        
        [_coverView addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        XYBankCardSection *section = [XYBankCardSection instanceWithSectionID:self.sectionID];
        _dataArray = [XYBankCardCache getAllCardModelsForSection:section];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认的title 【所有卡片】
    self.title = SectionNameAll;
    self.sectionID = @(1);
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupNav];
    
    [self buildUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    [self addNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadPageDataAndRefresh];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 添加通知
 */
- (void)addNotifications{
    
    [kNotificationCenter addObserver:self selector:@selector(reloadPageDataAndRefresh) name:BankCardDidChangedNotification object:nil];
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}


- (void)leftItemClick{
    
    if (!self.navigationItem.leftBarButtonItem.enabled) return; // 当左item不可用，即编辑卡片组，不可用
    
    NSLog(@"左边被点击，弹出功能菜单");
    
    if (self.frontView.transform.tx) {
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
            self.frontView.transform = CGAffineTransformIdentity;
            self.backView.transform = CGAffineTransformIdentity;
        }];
        
        // 1. 移除蒙版，接受用户事件
        [self.coverView removeFromSuperview];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.navigationBar.transform = CGAffineTransformTranslate(self.navigationController.navigationBar.transform, slipeWidth, 0);
            self.frontView.transform = CGAffineTransformTranslate(self.frontView.transform, slipeWidth, 0);
            self.backView.transform = CGAffineTransformTranslate(self.backView.transform, -slipeWidth, 0);
            //self.backView.transform = CGAffineTransformScale(self.backView.transform, slipeWidth/(ScreenW - slipeWidth), ScreenH/(ScreenH - 2 * 100));
        }];
        
        // 1. 添加蒙版，不再接受用户事件
        [self.frontView addSubview:self.coverView];
    }
}

- (void)setupNav{
    
    // nav
    UIBarButtonItem *leftFuncItem = [[UIBarButtonItem alloc] initWithTitle:@"功能" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftFuncItem;
}


- (void)buildUI{

    // 背景View
    XYBankCardBgViewController *bgVC = [XYBankCardBgViewController new];
    bgVC.delegate = self;
    [self addChildViewController:bgVC];
    UIView *backView = bgVC.view;
    backView.frame = CGRectMake(slipeWidth, 0, slipeWidth, ScreenH);
    backView.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:0.5];
    [self.view addSubview:backView];
    self.backView = backView;
    
    // 前景View
    UIView *frontView = [UIView new];
    frontView.frame = self.view.bounds;
//    frontView.backgroundColor = [UIColor redColor];
    [self.view addSubview:frontView];
    self.frontView = frontView;
    
    // tableview And toolbar
    CGFloat toolBarH = (iPhoneX) ? 74 : 44;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = UIColor.clearColor;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.frontView addSubview:tableView];
    UIImage *bgImage = [UIImage imageNamed:@"blur_bg"];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
    
    __block XYToolBar *toolBar = [[XYToolBar alloc] initWithLeftImage:@"tool_help" title:@"+ 添加新卡片" rightImage:@"tool_search" callbackHandler:^(UIButton *item) {
//        NSLog(@"item = %@",item);
        switch (item.tag) {
            case XYToolbarItemPositionLeft:
                {
                    [self gotoHelpPage];
                }
                break;
                
            case XYToolbarItemPositionMiddle:
            {
                [self gotoAddNewCardPage];
            }
                break;
                
            case XYToolbarItemPositiondRight:
            {
                [self gotoSearchCard];
            }
                break;
                
            default:
                break;
        }
    }];
    [self.frontView addSubview:toolBar];
    self.toolBar = toolBar;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.frontView).offset(0);
        make.left.equalTo(self.frontView);
        make.right.equalTo(self.frontView);
        make.bottom.equalTo(self.frontView).offset(0); // -(toolBarH)
    }];
    
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.frontView);
        make.right.equalTo(self.frontView);
        make.bottom.equalTo(self.frontView);
        make.height.equalTo(@(toolBarH));
    }];
    
    
    // 监听滑动的过程中back 的frame
//    [self.backView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    NSLog(@"keyPath = %@",keyPath);
//}



#pragma mark - BankCardBgVCDelegate

- (void)backgroundView:(UIView *)bgView isEditing:(BOOL)isEdit
{
    // 根据背静的View是否是edit状态来调整frontView的可用状态
    if (isEdit) {
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }else
    {
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }
}

- (void)backgroundView:(UIView *)bgView didChooseSection:(XYBankCardSection *)section
{
    // 1.回到主页面
    [self leftItemClick];
    
    // 2.修改主页面的UI数据<加载对应页面的卡信息>
    self.title = section.title;
    self.sectionID = section.sectionID;
    
    [self reloadPagedatasWithSection:section];
}


/**
 根据section刷新主页数据
 */
- (void)reloadPagedatasWithSection:(XYBankCardSection *)section
{
    // 刷新数据
    [self reloadPageDataAndRefresh];
    
    NSLog(@"%@",self.dataArray);
}

/**
 ToolBar 左侧按钮点击进入help
 */
- (void)gotoHelpPage{
//    [XYAlertView showAlertOnVC:self title:@"提示" message:@"进入帮助页面，github 网页？" okTitle:@"好的" Ok:nil];
//    [self reloadPageDataAndRefresh];
    
    XYSettingViewController *listVC = [XYSettingViewController new];
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:listVC];
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nav animated:YES completion:nil];

}

/**
 ToolBar 添加按钮点击进入添加新卡页面
 */
- (void)gotoAddNewCardPage{
    
//    // 直接添加一张先走流程
//    XYBankCardModel *card = [XYBankCardModel new];
//    card.frontIcon = @"carIcon";
//    card.rearIcon = @"carIcon";
//    card.name = @"万事达";
//    card.cardNumber = @"62220412012338445";
//    card.desc = @"我就是一张普通卡片";
//
//    // 这里也是根据自己title来找到对应的section
//    XYBankCardSection *section = [XYBankCardSection instanceWithTitle:self.title];
//    [XYBankCardCache saveNewCard:card forSection:section];
//
//    // 刷新页面数据
//    [self reloadPageDataAndRefresh];
    
    /// 进入对应的列表页面
    XYAddCardController *listVC = [XYAddCardController new];
    listVC.sectionID = self.sectionID;
    [self.navigationController pushViewController:listVC animated:YES];

}

/**
 ToolBar 右侧按钮点击查询卡片
 */
- (void)gotoSearchCard{
    
    self.dataArray = @[@"d",@"ddd"].mutableCopy;


    // 先刷新数据
//    [self.tableView reloadData];
    
    if (!self.dataArray.count) { // 没有数据直接显示本组没有数据。
        // 中间部分提示 【组名】中没有卡片
        [self showEmptyView];
    }else{
        // 有数据移除emptyView
        [_emptyView removeFromSuperview];
        _emptyView = nil;
    }
    
}


/**
 刷新数据和列表，默认根据自己title所代表的组
 */
- (void)reloadPageDataAndRefresh{
    
    // 刷新数据和列表
    XYBankCardSection *section = [XYBankCardSection instanceWithSectionID:self.sectionID];
    self.dataArray = [XYBankCardCache getAllCardModelsForSection:section];
    
    // 先刷新数据
    [self.tableView reloadData];
    
    if (!self.dataArray.count) { // 没有数据直接显示本组没有数据。
        // 中间部分提示 【组名】中没有卡片
        [self showEmptyView];
    }else{
        // 有数据移除emptyView
        [_emptyView removeFromSuperview];
        _emptyView = nil;
    }
    
}

- (void)showEmptyView{
    
    NSString *emptyStr = [NSString stringWithFormat:@"『%@』中没有卡片",self.title];
    
    
    if (!_emptyView) {
        _emptyView = [[UILabel alloc] initWithFrame:self.view.bounds];
        
        // 1. 图片
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nocard"]];
        
        // 2. 文字
        UILabel *label = [UILabel new];
        label.text = emptyStr;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        [_emptyView addSubview:imageView];
        [_emptyView addSubview:label];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self->_emptyView);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_emptyView);
            make.top.equalTo(imageView.mas_bottom).offset(0);
        }];
    }
    
    UILabel *label = _emptyView.subviews.lastObject;
    label.text = emptyStr;
    
    [self.tableView.backgroundView addSubview:_emptyView];
}




#pragma mark - Table view data source

- (UIView *)tableHeaderView{
    
    UIView *header = [UIView new];
    
    _tableHeaderView = [UILabel new];
    _tableHeaderView.text = [NSString stringWithFormat:@"[%@]数量:%ld",self.title,self.dataArray.count];
//    _tableHeaderView.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    _tableHeaderView.textColor = [UIColor greenColor];
    _tableHeaderView.textAlignment = NSTextAlignmentCenter;
    [_tableHeaderView sizeToFit];
    
    [header addSubview:_tableHeaderView];
    [_tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.center.equalTo(header);
        make.bottom.equalTo(header).offset(0);
    }];
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self tableHeaderView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    //    cell.textLabel.text = [NSString stringWithFormat:@"第 %zd 个 cell",indexPath.row];
//    XYBankCardModel *card = self.dataArray[indexPath.row];
//    cell.textLabel.text = card.name;
//    cell.backgroundColor = indexPath.row % 2 ? [UIColor purpleColor]: [UIColor greenColor];
    
    XYCardNormalCell *cell = [XYCardNormalCell cellWithTableView:tableView];
    
    XYBankCardModel *card = self.dataArray[indexPath.row];
    cell.model = card;
    
//    cell.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 点击对应的卡组处理
    // 返回主页并刷新最新数据
    // 可以用自己的delegate去做这件事
    
//    [XYAlertView showAlertTitle:@"提示" message:@"进入卡信息页面" Ok:nil];
    
    XYBankCardDetailController *detail = [XYBankCardDetailController new];
    detail.bankCard = self.dataArray[indexPath.row];
    UINavigationController *nav = [[NSClassFromString(@"XYNavigationController") alloc] initWithRootViewController:detail];
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nav animated:YES completion:nil];
    
}



@end
