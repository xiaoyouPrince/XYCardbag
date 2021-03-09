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
    self.title = NSLocalizedString(@"添加分组", nil);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", nil) style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    UIImage *bgImage = [UIImage imageNamed:@"blur_bg"];
    self.view = [[UIImageView alloc] initWithImage:bgImage];
    self.view.userInteractionEnabled = YES;
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = NSLocalizedString(@"名称", nil);
    nameLabel.textColor = [UIColor whiteColor];
    [nameLabel sizeToFit];
    [self.view addSubview:nameLabel];
    
    UITextField *nameTF = [UITextField new];
    nameTF.placeholder = NSLocalizedString(@"输入分类名", nil);
    nameTF.placeholderColor = [UIColor grayColor];
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
    
    
    for(int i = 0; i < 38 ; i++){
        // 第x行,第y列
        int x = i / clums;
        int y = i % clums;
        
        UIButton *btn = [UIButton new];
        btn.tag = i;
        NSString *imageName = [NSString stringWithFormat:@"category_icon_%02d",i];
        
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
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
    NSString *icon = [NSString stringWithFormat:@"category_icon_%02zd",self.selectBtn.tag];
    NSString *title = self.nameTF.text;
    XYBankCardSection *section = [XYBankCardSection new];
    section.icon = icon;
    section.title = title;
    [XYBankCardCache saveNewCardSection:section];
    
    //2. 退出
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.didSaveNewCategoryBlock) {
            self.didSaveNewCategoryBlock();
        }
    }];
}

- (void)chooseCategoryImageWithBtn:(UIButton *)btn{
    
    self.selectBtn.selected = NO;   // 之前选中的，取消选中
    btn.selected = YES;             // 选中最新Btn
    self.selectBtn = btn;           // 设置最新Btn为选中btn
}


@end
