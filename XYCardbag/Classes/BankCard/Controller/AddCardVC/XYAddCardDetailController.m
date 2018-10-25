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
#import "XYBankCardModel.h"
#import "XYNavigationController.h"
#import "XYBankCardCache.h"
#import "Masonry.h"

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

- (UIButton *)editBtn{
    static UIButton * editBtn;
    if (!editBtn) {
        editBtn = [[UIButton alloc] init];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(setTableViewEditing:) forControlEvents:UIControlEventTouchUpInside];
        [editBtn sizeToFit];
    }
    
    NSMutableArray *sectionTwo = self.dataArray.lastObject;
    if (sectionTwo.count > 4) { // 四个基本数据，不可编辑
        editBtn.hidden = NO;
    }else{
        editBtn.hidden = YES;
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.tableView.editing = NO;
    }
    
    return editBtn;
}

- (void)setTableViewEditing:(UIButton *)sender{
    
    if ([sender.currentTitle isEqualToString:@"编辑"]) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        self.tableView.editing = YES;
    }else if([sender.currentTitle isEqualToString:@"完成"]) {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        self.tableView.editing = NO;
    }
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
        
        UIButton *editBtn = [self editBtn];
        editBtn.frame = CGRectMake(ScreenW - 20 - editBtn.xy_width, 0, editBtn.xy_width, editBtn.xy_height);
        [_headerTwo addSubview:editBtn];
        
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
    
    self.title = @"添加卡片";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    
    
    // 创建对应的data数据
    XYCardInfoModel *imageInfo = [XYCardInfoModel new];
    imageInfo.tagType = TagTypeBaseImage;
    
    XYCardInfoModel *nameInfo = [XYCardInfoModel new];
    nameInfo.tagType = TagTypeBaseName;
    
    XYCardInfoModel *numberInfo = [XYCardInfoModel new];
    numberInfo.tagType = TagTypeBaseNumber;
    
    XYCardInfoModel *descInfo = [XYCardInfoModel new];
    descInfo.tagType = TagTypeBaseDesc;
    
    XYCardInfoModel *addInfo = [XYCardInfoModel new];
    addInfo.tagType = TagTypeAdd;
    
    self.dataArray = [NSMutableArray array];
    NSMutableArray *sectionTwo = [NSMutableArray arrayWithObjects:nameInfo,numberInfo,descInfo,addInfo, nil];
    [self.dataArray addObjectsFromArray:@[@[imageInfo],sectionTwo]];
    
}

static XYNavigationController *selfNav;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 禁用返回手势
    selfNav = (XYNavigationController *)self.navigationController;
    [selfNav setEdgePopGestureEnable:NO];
    
    // 检查是够可以显示editBtn
    [self editBtn];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // 开启返回手势
    [selfNav setEdgePopGestureEnable:YES];
    
    [super viewWillDisappear:animated];
}

- (void)leftItemClick:(UIBarButtonItem *)item{
    // 直接返回到rootVC即可
    
    [self.view endEditing:YES];
    
#warning TODO - 这里需要根据用户有没有填写数据，如果写了数据，提示用户是否确认返回，否则直接返回
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)rightItemClick:(UIBarButtonItem *)item{
    
    [self.view endEditing:YES];
#warning TODO - 这里需要根据用户有没有填写完整数据，数据完整就保存，不完整提示用户未填项目
    
    
    // 1. 验证必填信息
    if (![self checkPramas]) { return;};
    
    
    // 0. 创建XYBankCardModel
    XYBankCardModel *cardModel = [XYBankCardModel new];
    
    // 1. 拿到所有用户填写过的数据.<dataArray中>
    NSArray *sectionOne = self.dataArray.firstObject;
    NSArray *sectionTwo = self.dataArray.lastObject;
    
    // 1.1 第一组卡片图片数据
    XYCardInfoModel *imageInfo = sectionOne.firstObject;
    cardModel.frontIconImage = imageInfo.frontIconImage;
    cardModel.rearIconImage = imageInfo.rearIconImage;
    
    NSLog(@"卡片前图是:%@,  后图是:%@",imageInfo.frontIconImage,imageInfo.rearIconImage);
    
    // 1.2 第二组，卡片的 name number desc 等属性信息
    for (XYCardInfoModel *cardInfo in sectionTwo) {
        
        switch (cardInfo.tagType) {
            case TagTypeBaseName:
            {
                cardModel.name = cardInfo.detail;
            }
                break;
            case TagTypeBaseNumber:
            {
                cardModel.cardNumber = cardInfo.detail;
            }
                break;
            case TagTypeBaseDesc:
            {
                cardModel.desc = cardInfo.detail;
            }
                break;
            case TagTypeDate:
            case TagTypePhoneNumber:
            case TagTypeMail:
            case TagTypeNetAddress:
            case TagTypeCustom:
            {
                // 这几种就是属于自定义tag类型的了，直接放到 cardModel.tags 的数组中。解析的时候再用
                [cardModel.tags addObject:cardInfo];
            }
                break;
                
            default:
                break;
        }
    }
    
    // 打印cardModel
    NSLog(@"cardModel = %@",cardModel);
    
    // 保存数据
    XYBankCardSection *section = [XYBankCardSection instanceWithSectionID:self.sectionID];
    [XYBankCardCache saveNewCard:cardModel forSection:section];
    
    // 退出页面
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (BOOL)checkPramas{
    
    NSArray *sectionOne = self.dataArray.firstObject;
    NSArray *sectionTwo = self.dataArray.lastObject;
    
    // 1.1 第一组卡片图片数据
    XYCardInfoModel *imageInfo = sectionOne.firstObject;
    if (!(imageInfo.frontIconImage || imageInfo.rearIconImage)) {
        // 图片不全
        [self showLossParamError:@"请至少添加一张图片!"];
        return NO;
    }
    
    // 2. name number desc
    for (XYCardInfoModel *cardInfo in sectionTwo) {
        switch (cardInfo.tagType) {
            case TagTypeBaseName:
            {
                if(!cardInfo.detail){
                    [self showLossParamError:@"请添加卡片名称!"];
                    return NO;
                }
            }
                break;
            case TagTypeBaseNumber:
            {
                if(!cardInfo.detail){
                    [self showLossParamError:@"请添加卡片号码!"];
                    return NO;
                }
            }
                break;
            case TagTypeBaseDesc:
            {
                if(!cardInfo.detail){
                    [self showLossParamError:@"请添加卡片描述!"];
                    return NO;
                }
            }
            default:
                break;
        }
        
    }
    
    return YES;
}

/**
 提示缺少信息的错误

 @param errorContent 错误内容
 */
- (void)showLossParamError:(NSString *)errorContent{
    
    CGFloat Y = kNavHeight - kTopBarHeight;
    CGRect frame = selfNav.navigationBar.bounds;
    frame.origin.y -= (Y + kNavHeight);
    frame.size.height = kNavHeight * 2;
    
    UIView *errorView = [[UIView alloc] initWithFrame:frame];
    errorView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    
    UIButton *errorBtn = [[UIButton alloc] init];
    UIImage *errorImage = [UIImage imageNamed:@"tool_help"];
    [errorBtn setImage:errorImage forState:UIControlStateNormal];
    [errorBtn setTitle:errorContent forState:UIControlStateNormal];
    
    [errorView addSubview:errorBtn];
    [selfNav.navigationBar insertSubview:errorView atIndex:0];
    
    [errorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(errorView);
        make.right.equalTo(errorView);
        make.bottom.equalTo(errorView);
        
        make.height.equalTo(@(kTopBarHeight));
    }];
    
    
    static CGFloat const animationDuration = 0.3;
    
    [UIView animateWithDuration:animationDuration animations:^{
        errorView.transform = CGAffineTransformMakeTranslation(0, kTopBarHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:animationDuration delay:animationDuration*2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            errorView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [errorView removeFromSuperview];
        }];
    }];
    
}
    
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *infoSection = self.dataArray[section];
    return infoSection.count;
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
    
    if (cardInfo.tagType == TagTypeBaseImage) {
        XYCardInfoCell *cell = [XYCardInfoCell cellForCardImagesWithTableView:tableView];
        cell.model = cardInfo;
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        if (cardInfo.tagType == TagTypeBaseName) {   // name
            XYCardInfoCell *cell = [XYCardInfoCell cellForCardNameWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
        
        if (cardInfo.tagType == TagTypeBaseNumber) {   // number
            XYCardInfoCell *cell = [XYCardInfoCell cellForCardNumberWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
        
        if (cardInfo.tagType == TagTypeBaseDesc) {   // desc
            XYCardInfoCell *cell = [XYCardInfoCell cellForCardDescWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
        
        if (cardInfo.tagType == TagTypeAdd) {   // add
            XYCardInfoCell *cell = [XYCardInfoCell cellForAddNewWithTableView:tableView];
            cell.model = cardInfo;
            return cell;
        }
    }
    
    // 其余的都是用户可以自己添加的
    XYCardInfoCell *cell = [XYCardInfoCell cellForCardInfoWithTableView:tableView model:cardInfo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
    if (indexPath.section == 0) return;
    
    NSArray *infoSection = self.dataArray[indexPath.section];
    if (indexPath.row == infoSection.count - 1) {
        
        // 最后一个cell点击进入，选择添加类别的页面,通过block回传添加的tag并放到自己打data中。 -- 当本页显示的时候再刷新
        /// 进入对应的列表页面
        XYAddNewCardTagController *listVC = [XYAddNewCardTagController new];
        [self.navigationController pushViewController:listVC animated:YES];
        listVC.addTagBlock = ^(XYCardInfoModel *model) {
            // 拿到添加的tag的modle . 添加到self.dataArray 中的第二组(最后一组)

            NSMutableArray *sectionTwo = self.dataArray[self.dataArray.count - 1];
            [sectionTwo insertObject:model atIndex:sectionTwo.count - 1];
            
            [self.tableView reloadData];
            
#warning mark -- 这里可以进行性能优化，只刷新最后一行
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sectionTwo.count inSection:1];
//            [self.tableView reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationFade];
        };
    }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section != 0) {
        NSArray *section = self.dataArray[indexPath.section];
        if (indexPath.row > 2 && indexPath.row != section.count-1) {
            return YES;
        }
    }
    
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSMutableArray *sectionArr = self.dataArray[indexPath.section];
        [sectionArr removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // 检查是够可以显示editBtn
        [self editBtn];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    
    if (proposedDestinationIndexPath.section != 0) { // 非第0组
        NSArray *section = self.dataArray[proposedDestinationIndexPath.section];
        if (proposedDestinationIndexPath.row > 2 && proposedDestinationIndexPath.row < section.count-1) {
            return proposedDestinationIndexPath;
        }else{
            NSInteger sourceRow = sourceIndexPath.row;
            NSMutableArray *sourceSection = [self.dataArray objectAtIndex:sourceIndexPath.section];
            NSUInteger sectionCount = [sourceSection count];
            
            if (sourceRow < 3) {
                sourceRow = 3;
            }
            if (sourceRow >= sectionCount - 1) {
                sourceRow -= 1;
            }
            return [NSIndexPath indexPathForRow:sourceRow inSection:sourceIndexPath.section];
        }
    }else   // 可移动当前组
    {
        NSInteger sourceRow = sourceIndexPath.row;
        NSMutableArray *sourceSection = [self.dataArray objectAtIndex:sourceIndexPath.section];
        NSUInteger sectionCount = [sourceSection count];
        
        if (sourceRow < 3) {
            sourceRow = 3;
        }
        if (sourceRow >= sectionCount - 1) {
            sourceRow -= 2;
        }
        return [NSIndexPath indexPathForRow:sourceRow inSection:sourceIndexPath.section];
    }
    
    return proposedDestinationIndexPath;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

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



#pragma mark -- scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
