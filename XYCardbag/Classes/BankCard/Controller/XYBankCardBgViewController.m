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

@interface XYBankCardBgViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic , strong) XYToolBar  *toolBar;
@property(nonatomic , strong) NSMutableArray  *dataArray;

@end

@implementation XYBankCardBgViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        [_dataArray addObject:@"所有卡片"];
        [_dataArray addObject:@"我的最爱"];
        [_dataArray addObject:@"交通"];
        [_dataArray addObject:@"人情"];
        [_dataArray addObject:@"新欢"];
        [_dataArray addObject:@"旧爱"];
        [_dataArray addObject:@"喝酒"];
        [_dataArray addObject:@"上学"];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self buildUI];

}


- (void)buildUI{
    
    static CGFloat toolBarH = 30;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = UIColor.clearColor;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    __block XYToolBar *toolBar = [[XYToolBar alloc] initWithLeftImage:@"carIcon" title:@"设置" rightImage:@"carIcon" callbackHandler:^(UIBarButtonItem *item) {
        NSLog(@"item = %@",item);
        
        UIColor *tintColor = item.tintColor;
        
        if ([item.title isEqualToString:@"设置"]) {
            // 1.自己状态改变
            item.tintColor = tintColor;
            item.title = @"完成";
            item.style = UIBarButtonItemStyleDone;
            // 2，tableView变成可编辑状态
            self.tableView.editing = YES;
            // 3. 其他部分隐藏并且只有自己的View有用户效果
            UIView *toolBarContentView = toolBar.subviews.lastObject.subviews.firstObject;
            NSMutableArray <UIView *>*arrayM = [NSMutableArray array];
            for (int i = 0; i < toolBarContentView.subviews.count; i ++) {
                // 内部itemView
                UIView *midItem = toolBarContentView.subviews[i];
                if ([midItem isKindOfClass:NSClassFromString(@"_UIButtonBarButton")]) {
                    [arrayM addObject:midItem];
                }
            }
            arrayM.firstObject.hidden = YES;
            arrayM.lastObject.hidden = YES;
            
            
            // 4. 通过delegate发消息传出去外界不可操作现在，只能等编辑完成才可以滑动回来。
            if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundView:isEditing:)]) {
                [self.delegate backgroundView:self.tableView isEditing:YES];
            }
        }else if ([item.title isEqualToString:@"完成"]) {
            
            // 1.自己状态改变
            item.tintColor = tintColor;
            item.title = @"设置";
            item.style = UIBarButtonItemStylePlain;
            
            // 2，tableView变成可编辑状态
            self.tableView.editing = NO;
            
            // 3. 其他部分隐藏并且只有自己的View有用户效果
            UIView *toolBarContentView = toolBar.subviews.lastObject.subviews.firstObject;
            for (int i = 0; i < toolBarContentView.subviews.count; i ++) {
                [toolBarContentView.subviews[i] setHidden:NO];
            }
            
            // 4.通过delegate发消息传出去外界可操作现在，已经编辑完成回归原来状态。
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
        make.height.equalTo(self.view).offset(-(toolBarH));
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

- (void)itemClick:(UIBarButtonItem *)item{
    NSLog(@"item = %@",item);
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundView:didChooseSectionName:)]) {
        [self.delegate backgroundView:self.tableView didChooseSectionName:self.dataArray[indexPath.row]];
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
    
    // 不允许移动前两个
    if (toIndexPath.row <= 1) {
        [self.tableView reloadData];
    }else
    {
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
}


@end
