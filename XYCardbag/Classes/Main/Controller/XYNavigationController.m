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
    UINavigationBar *navBar = nil;

    if (@available(iOS 9.0, *)) {
        navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    }else{
        navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    }
    
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
    
    // tintColor
    navBar.tintColor = [UIColor whiteColor];
    
}

- (void)setEdgePopGestureEnable:(BOOL)enable
{
    _canHandleGesture = enable;
}


static BOOL _canHandleGesture = YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIPanGestureRecognizer *edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:) ];
    edgePan.delegate = self;
    [self.view addGestureRecognizer:edgePan];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return (self.childViewControllers.count > 1 && _canHandleGesture); // 有自控制器的时候恢复返回手势
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
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
