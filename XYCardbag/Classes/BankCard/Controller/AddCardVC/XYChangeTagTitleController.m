//
//  XYChangeTagTitleController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/23.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//
//  添加卡片信息后，修改自定义tag title的页面

#import "XYChangeTagTitleController.h"
#import "Masonry.h"
#import "XYCardInfoModel.h"

@interface XYChangeTagTitleController ()<UIScrollViewDelegate>
@property(nonatomic , weak)     UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UILabel *tagStringLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewBottomCons;

@end

@implementation XYChangeTagTitleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置约束让 editView 正常显示在scrollView上
    self.editViewBottomCons.constant = ScreenH - self.editViewTopCons.constant - kNavHeight - 43.5;
    if (iPhoneX) {
        self.editViewBottomCons.constant -= 34; // 多减去一个底边的 safeEdge
    }
    
    [self buildUI];
}


- (void)setupNav{
    
    // nav.title
    self.title = @"标签";
}

- (void)leftItemClick:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.titleTF.text.length) {
        self.tag.title = self.titleTF.text;
        if (self.changeTitleBlock) {
            self.changeTitleBlock(YES);
        }
    }
}



- (void)buildUI{
    
    [self setupNav];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.tagStringLabel.text = self.tag.tagString;
    self.titleTF.text = self.tag.title;
    [self.titleTF becomeFirstResponder];
}


- (void)setTag:(XYCardInfoModel *)tag
{
    _tag = tag;
}


@end
