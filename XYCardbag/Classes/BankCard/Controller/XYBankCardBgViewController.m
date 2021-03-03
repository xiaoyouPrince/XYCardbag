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
#import "XYToolBar.h"
#import "XYBankCardCache.h"
#import "XYNavigationController.h"
#import "XYAddCategoryController.h"
#import "XYSettingViewController.h"

@interface XYBankCardBgViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) XYToolBar  *toolBar;
@property(nonatomic , strong) NSMutableArray  <XYBankCardSection *>*dataArray;

@end

@implementation XYBankCardBgViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [XYBankCardCache getAllCardSections];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dataArray = [XYBankCardCache getAllCardSections];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 主动选中一下所有卡片
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

- (void)buildUI{
    
    CGFloat toolBarH = (iPhoneX) ? 74 : 44;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = UIColor.clearColor;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    UIImage *bgImage = [UIImage imageNamed:@"blur_bg"];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
    
    __block XYToolBar *toolBar = [[XYToolBar alloc] initWithLeftImage:@"tool_add" title:@"设置" rightImage:@"tool_config" callbackHandler:^(UIButton *item) {
//        NSLog(@"item = %@",item);
        
        if (item.tag == XYToolbarItemPositionLeft) {
            NSLog(@"左边item = 新添加");
            [self addNewCardSection];
            return;
        }
        
        if (item.tag == XYToolbarItemPositiondRight) {
            NSLog(@"右边item = 进入设置页面");
            
            XYSettingViewController *listVC = [XYSettingViewController new];
            XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:listVC];
            nav.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:nav animated:YES completion:nil];
            
            return;
        }
        
        if ([item.currentTitle isEqualToString:@"设置"]) {
            // 1.自己状态改变
            [item setTitle:@"完成" forState:UIControlStateNormal];
            UIColor *color = XYColor(44, 183, 245);
            [item setTitleColor:color forState:UIControlStateNormal];
            
            // 2，tableView变成可编辑状态
            self.tableView.editing = YES;
            
            // 3. 通过delegate发消息传出去外界不可操作现在，只能等编辑完成才可以滑动回来。
            if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundView:isEditing:)]) {
                [self.delegate backgroundView:self.tableView isEditing:YES];
            }
            
        }else if ([item.currentTitle isEqualToString:@"完成"]) {
            
            // 1.自己状态改变
            [item setTitle:@"设置" forState:UIControlStateNormal];
            [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            // 2，tableView变成可编辑状态
            self.tableView.editing = NO;
            
            // 3.通过delegate发消息传出去外界可操作现在，已经编辑完成回归原来状态。
            if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundView:isEditing:)]) {
                [self.delegate backgroundView:self.tableView isEditing:NO];
            }
        }
    }];
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(self.view).offset(0); // -(toolBarH)
    }];
    
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@(toolBarH));
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

- (void)addNewCardSection{
    
    // 弹出一个添加新卡组的页面
    /// 进入对应的列表页面
    XYAddCategoryController *listVC = [XYAddCategoryController new];
    listVC.didSaveNewCategoryBlock = ^{
        // 更新数据源，从开始
        self.dataArray = nil;
        [self.tableView reloadData];
    };
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:listVC];
    [self presentViewController:nav animated:YES completion:nil];
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
    XYBankCardSection *section = self.dataArray[indexPath.row];
    cell.textLabel.text = section.title;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.backgroundColor = UIColor.clearColor;//indexPath.row % 2 ? [UIColor purpleColor]: [UIColor greenColor];
    cell.imageView.image = [UIImage imageNamed:section.icon];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 点击对应的卡组处理
    // 返回主页并刷新最新数据
    // 可以用自己的delegate去做这件事
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundView:didChooseSection:)]) {
        [self.delegate backgroundView:self.tableView didChooseSection:self.dataArray[indexPath.row]];
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 1) {
        return YES;
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 1) {
        return YES;
    }
    return NO;
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
            [XYBankCardCache deleteCardSection:self.dataArray[indexPath.row]];
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            
        }];
        [al addAction:action1];
        [self presentViewController:al animated:YES completion:nil];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        // 添加功能在底部toolBar上
//        NSString *new = [NSString stringWithFormat:@"%ld",self.dataArray.count + 1];
//        [self.dataArray addObject:new];
//        [[self tableView] reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return -1;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
   
//    NSDictionary *section = [self.dataArray objectAtIndex:sourceIndexPath.section];
//    NSUInteger sectionCount = [[section valueForKey:@"content"] count];
//    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
//        NSUInteger rowInSourceSection =
//        (sourceIndexPath.section > proposedDestinationIndexPath.section) ?
//        0 : sectionCount - 1;
//        return [NSIndexPath indexPathForRow:rowInSourceSection inSection:sourceIndexPath.section];
//    } else if (proposedDestinationIndexPath.row >= sectionCount) {
//        return [NSIndexPath indexPathForRow:sectionCount - 1 inSection:sourceIndexPath.section];
//    }
    
    if (proposedDestinationIndexPath.row < 2) { // 默认[所有卡片][我的最爱]不可移动
         return [NSIndexPath indexPathForRow:2 inSection:sourceIndexPath.section];
    }
    
    // Allow the proposed destination.
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    // 不允许移动前两个
    if (toIndexPath.row <= 1) {
        [self.tableView reloadData];
    }else
    {
        // 移动数据源
        id from = [self.dataArray objectAtIndex:fromIndexPath.row];
        // id to = [self.dataArray objectAtIndex:toIndexPath.row];
        
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
    
    
    
#warning todo -- 用户修改位置，这里进行数据持久化 ---
}


@end
