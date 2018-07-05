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

@interface XYBankCardController ()<BankCardBgVCDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UIView *frontView;
@property(nonatomic,weak) UIView *backView;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) XYToolBar  *toolBar;
@property(nonatomic , strong) NSMutableArray  *dataArray;

@end

@implementation XYBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self buildUI];
    
    UIBarButtonItem *leftFuncItem = [[UIBarButtonItem alloc] initWithTitle:@"功能" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftFuncItem;

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
    static CGFloat toolBarH = 44;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = UIColor.clearColor;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.frontView addSubview:tableView];
    
    __block XYToolBar *toolBar = [[XYToolBar alloc] initWithLeftImage:@"carIcon" title:@"+ 添加新卡片" rightImage:@"carIcon" callbackHandler:^(UIBarButtonItem *item) {
        NSLog(@"item = %@",item);
    }];
    [self.frontView addSubview:toolBar];
    self.toolBar = toolBar;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.frontView);
        make.left.equalTo(self.frontView);
        make.right.equalTo(self.frontView);
        make.height.equalTo(self.frontView).offset(-(toolBarH));
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
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //    cell.textLabel.text = [NSString stringWithFormat:@"第 %zd 个 cell",indexPath.row];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.backgroundColor = indexPath.row % 2 ? [UIColor purpleColor]: [UIColor greenColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 点击对应的卡组处理
    // 返回主页并刷新最新数据
    // 可以用自己的delegate去做这件事
    
}



@end
