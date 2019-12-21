//
//  XYNavigationController.m
//  XYCardbag
//
//  Created by xiaoyou on 2017/12/19.
//  Copyright © 2017年 xiaoyou. All rights reserved.
//

#import "XYNavigationController.h"

@interface XYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XYNavigationController

// 设置nav的字体颜色和大小等
+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    // title 的大小和颜色
    NSMutableDictionary *attrs = [NSMutableDictionary new];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:22];
    [navBar setTitleTextAttributes:attrs];
    
    // backIndicator
    [navBar setBackIndicatorImage:[UIImage imageNamed:@"navigationButtonReturn"]];
    [navBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navigationButtonReturn"]]; // 这两个需要同时设置
    
    // backgroundView
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:0.2 alpha:0.8]];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // barTintColor 与上冲突
    // navBar.barTintColor = [UIColor colorWithWhite:0.2 alpha:0.8];[UIColor redColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIPanGestureRecognizer *edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:) ];
    edgePan.delegate = self;
    [self.view addGestureRecognizer:edgePan];
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    static BOOL canHandleGesture = YES;
    static CGFloat popGestureRatio = 0.1;
        
    // 查看返回设置,是否禁用侧滑返回手势
    if ([self.childViewControllers.lastObject respondsToSelector:@selector(xy_disablePopGesture)]) {
        canHandleGesture = ![self.childViewControllers.lastObject xy_disablePopGesture];
    }
    
    // 处理自动返回比例
    if ([self.childViewControllers.lastObject respondsToSelector:@selector(xy_popGestureRatio)]) {
        CGFloat realRatio = [self.childViewControllers.lastObject xy_popGestureRatio];
        popGestureRatio = MAX(realRatio, popGestureRatio);
    }
    
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    return canHandleGesture && (point.x <= popGestureRatio * gestureRecognizer.view.bounds.size.width);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        // 返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  target:self action:@selector(back) title:@"返回"];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

@end
