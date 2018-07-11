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

@interface XYBankCardController ()<BankCardBgVCDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UIView *frontView;
@property(nonatomic,weak) UIView *backView;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) XYToolBar  *toolBar;
@property(nonatomic , strong) NSMutableArray  *dataArray;

@end

@implementation XYBankCardController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        XYBankCardSection *section = [XYBankCardSection instanceWithTitle:self.title];
        _dataArray = [XYBankCardCache getAllCardModelsForSection:section];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认的
    self.title = @"Bank card ";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self buildUI];
    
    UIBarButtonItem *leftFuncItem = [[UIBarButtonItem alloc] initWithTitle:@"功能" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftFuncItem;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadPageDataAndRefresh];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)leftItemClick{
    
    NSLog(@"左边被点击，弹出功能菜单");
    
    if (self.frontView.transform.tx) {
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
            self.frontView.transform = CGAffineTransformIdentity;
            self.backView.transform = CGAffineTransformIdentity;
//            self.backView.frame = CGRectMake(slipeWidth, 100, ScreenW - slipeWidth, ScreenH - 2 * 100);
        }];
    }else
    {
        
        CGFloat backOffset = slipeWidth - ScreenW/2;  // 背景移动缩放过程中偏移量
        CGFloat backSlip = -(slipeWidth - backOffset);  // 真实的背景移动距离
        
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.navigationBar.transform = CGAffineTransformTranslate(self.navigationController.navigationBar.transform, slipeWidth, 0);
            self.frontView.transform = CGAffineTransformTranslate(self.frontView.transform, slipeWidth, 0);
            self.backView.transform = CGAffineTransformTranslate(self.backView.transform, backSlip, 0);
            self.backView.transform = CGAffineTransformScale(self.backView.transform, slipeWidth/(ScreenW - slipeWidth), ScreenH/(ScreenH - 2 * 100));
        }];
    }
    
    
    
}


- (void)buildUI{

    // 背景View
    XYBankCardBgViewController *bgVC = [XYBankCardBgViewController new];
    bgVC.delegate = self;
    [self addChildViewController:bgVC];
    UIView *backView = bgVC.view;
    backView.frame = CGRectMake(slipeWidth, 100, ScreenW - slipeWidth, ScreenH - 2 * 100);
    backView.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:0.5];
    [self.view addSubview:backView];
    self.backView = backView;
    
    // 前景View
    UIView *frontView = [UIView new];
    frontView.frame = self.view.bounds;
    frontView.backgroundColor = [UIColor redColor];
    [self.view addSubview:frontView];
    self.frontView = frontView;
    
    // tableview And toolbar
    CGFloat toolBarH = (iPhoneX) ? 88 : 44;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = UIColor.clearColor;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.frontView addSubview:tableView];
    
    __block XYToolBar *toolBar = [[XYToolBar alloc] initWithLeftImage:@"carIcon" title:@"+ 添加新卡片" rightImage:@"carIcon" callbackHandler:^(UIBarButtonItem *item) {
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
        make.top.equalTo(self.frontView).offset(kNavHeight);
        make.left.equalTo(self.frontView);
        make.right.equalTo(self.frontView);
        make.bottom.equalTo(self.frontView).offset(-(toolBarH));
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

#pragma BankCardBgVCDelegate
- (void)backgroundView:(UIView *)bgView isEditing:(BOOL)isEdit
{
    // 根据背静的View是否是edit状态来调整frontView的可用状态
    if (isEdit) {
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.frontView.userInteractionEnabled = NO;
    }else
    {
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.frontView.userInteractionEnabled = YES;
    }
}

- (void)backgroundView:(UIView *)bgView didChooseSectionName:(NSString *)sectionName
{
    // 1.回到主页面
    [self leftItemClick];
    
    // 2.修改主页面的UI数据<加载对应页面的卡信息>
    self.title = sectionName;
    
    [self reloadPagedatasWithSectionName:sectionName];
}


/**
 根据sectionName刷新主页数据
 */
- (void)reloadPagedatasWithSectionName:(NSString *)sectionName
{
    if (sectionName == nil) {
        sectionName = @"所有卡片";
    }
    
    // 刷新数据
    [self reloadPageDataAndRefresh];
    
    NSLog(@"%@",self.dataArray);

}

/**
 ToolBar 左侧按钮点击进入help
 */
- (void)gotoHelpPage{
    [XYAlertView showAlertTitle:@"亲爱的" message:@"有事打电话" Ok:nil];
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
    listVC.sectionTitle = self.title;
    [self.navigationController pushViewController:listVC animated:YES];

}

/**
 ToolBar 右侧按钮点击查询卡片
 */
- (void)gotoSearchCard{
    
}


/**
 刷新数据和列表，默认根据自己title所代表的组
 */
- (void)reloadPageDataAndRefresh{
    
    // 刷新数据和列表
    XYBankCardSection *section = [XYBankCardSection instanceWithTitle:self.title];
    self.dataArray = [XYBankCardCache getAllCardModelsForSection:section];
    [self.tableView reloadData];
}




#pragma mark - Table view data source

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
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 点击对应的卡组处理
    // 返回主页并刷新最新数据
    // 可以用自己的delegate去做这件事
    
    [XYAlertView showAlertTitle:@"提示" message:@"进入卡信息页面" Ok:nil];
    
}



@end
