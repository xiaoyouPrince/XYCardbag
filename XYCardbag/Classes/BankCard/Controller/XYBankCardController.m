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

@interface XYBankCardController ()<BankCardBgVCDelegate>

@property(nonatomic,weak) UIView *frontView;
@property(nonatomic,weak) UIView *backView;

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
    
    XYBankCardBgViewController *bgVC = [XYBankCardBgViewController new];
    bgVC.delegate = self;
    [self addChildViewController:bgVC];
    UIView *backView = bgVC.view;
    backView.frame = CGRectMake(slipeWidth, 100, ScreenW - slipeWidth, ScreenH - 2 * 100);
//    backView.frame = CGRectMake(slipeWidth, 0 , slipeWidth, ScreenH);
    backView.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:0.5];
    [self.view addSubview:backView];
    self.backView = backView;
    
    UIView *frontView = [UIView new];
    frontView.frame = self.view.bounds;
    frontView.backgroundColor = [UIColor redColor];
    [self.view addSubview:frontView];
    self.frontView = frontView;
    
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



@end
