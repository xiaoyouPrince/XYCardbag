//
//
//  XYAddCategoryController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/6.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  这是一个添加卡片分组的页面

#import "XYAddCategoryController.h"
#import "Masonry.h"
#import "XYBankCardModel.h"
#import "XYBankCardCache.h"

@interface XYAddCategoryController ()
@property(nonatomic,weak) UITextField *nameTF;
@property(nonatomic,weak) UIButton *selectBtn;

@end

@implementation XYAddCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI{
    // 创建UI页面
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    self.title = @"添加分组";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"名称";
    [nameLabel sizeToFit];
    [self.view addSubview:nameLabel];
    
    UITextField *nameTF = [UITextField new];
    nameTF.placeholder = @"输入分类名";
    nameTF.borderStyle = UITextBorderStyleRoundedRect;
    [nameTF becomeFirstResponder];
    [self.view addSubview:nameTF];
    self.nameTF = nameTF;
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:line];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.equalTo(self.view).offset(kNavHeight + 20);
    }];
    
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel).offset(50);
        make.center.equalTo(nameLabel).offset(0);
        make.right.equalTo(self.view).offset(-50);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.height.equalTo(@1);
    }];
    
    
    // 一些图标
    int clums = 6; // 5列
    // 每个item宽高 和边距
    CGFloat margin = 20;
    CGFloat WH = (ScreenW - 2*margin)/ clums;
    
    
    for(int i = 0; i < 36 ; i++){
        // 第x行,第y列
        int x = i / clums;
        int y = i % clums;
        
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageWithColor:UIColor.greenColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithColor:UIColor.redColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"carIcon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseCategoryImageWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line).offset(x * WH + margin);
            make.left.equalTo(self.view).offset(y * WH + margin);
            make.width.height.equalTo(@(WH));
        }];
        
        if (i == 0) { // 默认是第一个选中
            [self chooseCategoryImageWithBtn:btn];
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.nameTF resignFirstResponder];
}


- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save{
    
    if (!self.nameTF.text.length) {
        if (self.nameTF.isFirstResponder) {
            [self.nameTF resignFirstResponder];
        }else{
         [self.nameTF becomeFirstResponder];
        }
        return;
    }
    
    //1. 保存信息
//    UIImage *icon = [self.selectBtn imageForState:UIControlStateNormal];
    NSString *icon = @"carIcon";
    NSString *title = self.nameTF.text;
    XYBankCardSection *section = [XYBankCardSection new];
    section.icon = icon;
    section.title = title;
    [XYBankCardCache saveNewCardSection:section];
    
    //2. 退出
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)chooseCategoryImageWithBtn:(UIButton *)btn{
    
    self.selectBtn.selected = NO;   // 之前选中的，取消选中
    btn.selected = YES;             // 选中最新Btn
    self.selectBtn = btn;           // 设置最新Btn为选中btn
}


@end