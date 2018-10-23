//
//  XYBankCardDetailController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/22.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import "XYBankCardDetailController.h"
#import "Masonry.h"
#import "XYCardInfoModel.h"
#import "XYBankCardModel.h"
#import "XYQrCodeView.h"

@interface XYBankCardDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)     NSMutableArray *dataArray;
@property(nonatomic , weak)     UITableView *tableView;
@end

@implementation XYBankCardDetailController
{
    CGFloat _descHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
}


- (void)setupNav{
    
    // nav.title
    self.title = self.bankCard.name;
    
    // nav.items
    UIBarButtonItem *leftFuncItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
    self.navigationItem.leftBarButtonItem = leftFuncItem;
    
    UIBarButtonItem *rightFuncItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightFuncItem;
}

- (void)leftItemClick:(UIBarButtonItem *)item{
    
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightItemClick:(UIBarButtonItem *)item{
    
    XYAlertShowDeveloper;
}

- (void)buildUI{
    
    [self setupNav];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.backgroundColor = UIColor.clearColor;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    _descHeight = [self calculatorStringHeight:nil];
    [self.tableView reloadData];
    
    XYQrCodeView *qrCodeView = [XYQrCodeView qrCodeViewWithContent:self.bankCard.cardNumber];
    qrCodeView.frame = CGRectMake(0, 0, 0, ScreenW * 0.6);
    self.tableView.tableHeaderView = qrCodeView;
    
}

- (void)setBankCard:(XYBankCardModel *)bankCard
{
    
    _bankCard = bankCard;
    
    // 页面分 为tableView.header + 两组
    // header   : card.number && qrCode
    // section1 : cardInfo => card.tags + card.desc
    // section2 : system functions
    
    self.dataArray = @[].mutableCopy;
    
    // section1 => card.tags + card.desc
    NSMutableArray *sectionOne = [NSMutableArray array];
    for (XYCardInfoModel *tag in bankCard.tags) {
        [sectionOne addObject:tag];
    }
    [sectionOne addObject:bankCard.desc];

    // section2
    NSMutableArray *sectionTwo = [NSMutableArray array];
    [sectionTwo addObject:@"拷贝所有"];
    [sectionTwo addObject:@"卡片图片"];
    [sectionTwo addObject:@"Passwork"];
    
    [self.dataArray addObject:sectionOne];
    [self.dataArray addObject:sectionTwo];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArr = self.dataArray[section];
    return sectionArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArr = self.dataArray[indexPath.section];
    if (indexPath.section == 0 && indexPath.row == sectionArr.count-1) {
        return _descHeight;
    }

    return 44;
}

- (CGFloat)calculatorStringHeight:(NSString *)str{
    
    NSString *desc = self.bankCard.desc;
    
    CGFloat margin = 30;
    CGSize size = CGSizeMake(ScreenW - 2*margin, CGFLOAT_MAX);
    UILabel *label = [UILabel new];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    style.lineSpacing = 10;
    NSDictionary *attr = @{ NSFontAttributeName : label.font,
                            NSParagraphStyleAttributeName : style
                            };
    
    CGRect bounds = [desc boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return bounds.size.height > 44 ? bounds.size.height : 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == self.dataArray.count-1) {
        return 30;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *sectionArr = self.dataArray[indexPath.section];

    cell.textLabel.text = [NSString stringWithFormat:@"%@",sectionArr[indexPath.row]];
    cell.textLabel.numberOfLines = 0;
    
    if (indexPath.section == 0 && indexPath.row == sectionArr.count-1 ) { // card.desc 显示为灰色
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.backgroundColor = [UIColor redColor];
    }else
    {
        cell.textLabel.textColor = [UIColor blackColor];
        
        if (indexPath.section == 0) { // 第一组的 tags 用其他样式的cell
            static NSString *tagCellID = @"tagCellID";
            UITableViewCell *tagCell = [tableView dequeueReusableCellWithIdentifier:tagCellID];
            if (!tagCell) {
                tagCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            }
            
            XYCardInfoModel *tag = sectionArr[indexPath.row];
            tagCell.textLabel.text = tag.title;
            tagCell.detailTextLabel.text = tag.detail;
            if (1) {
                UIImage *remind = [UIImage imageNamed:@"wizard_normalcard"];
                tagCell.accessoryView = [[UIImageView alloc] initWithImage:remind];
            }
            
            return tagCell;
        }
    }
    
    if (indexPath.section == self.dataArray.count-1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYAlertShowDeveloper;
    
}




@end
