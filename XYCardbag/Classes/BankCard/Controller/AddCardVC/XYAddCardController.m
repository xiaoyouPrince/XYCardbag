//
//
//  XYAddCardController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/6.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  添加新卡页面

#import "XYAddCardController.h"
#import "XYAddCardDetailController.h"

@interface XYAddCardController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottomCons;
@end

@implementation XYAddCardController


#pragma mark -- life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加卡片";
    
    // 相差44 是因为，导航条高度是44。这种单ScrollView的VC在有导航条的时候会自动修改ScrollView的contentInset以自适应，使之正确展示内容
    self.viewBottomCons.constant -= 43.5; // 这里自适应少减去1像素，在屏幕中contentSize就大于frame.size 了，可以正常滚动。
}

- (IBAction)cellTapBegin:(UITapGestureRecognizer *)sender {
    
    UIView *cell = sender.view;
    switch (cell.tag) {
        case 0:
        {
            NSLog(@"点击普通卡");
            /// 进入对应的列表页面
            XYAddCardDetailController *listVC = [XYAddCardDetailController new];
            listVC.sectionTitle = self.sectionTitle;
            [self.navigationController pushViewController:listVC animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"点击信用卡💳");
        }
            break;
        case 2:
        {
            NSLog(@"点击会员卡");
        }
            break;
        default:
            break;
    }
}


@end
