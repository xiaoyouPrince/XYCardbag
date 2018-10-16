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
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    // backgroundView
    [navBar setBackIndicatorImage:[UIImage imageNamed:@"navigationButtonReturn"]];
    [navBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navigationButtonReturn"]]; // 这两个需要同时设置
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:0.2 alpha:0.80]];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
//    UIColor *tintColor = [UIColor colorWithWhite:0.2 alpha:0.40];
//    navBar.barTintColor = tintColor;
    
//    navBar.tintColor  
//    navBar.backgroundColor
    
    // 结论：navBar 设置背景使用图片！
    /*
     1.优先使用 setBackgroundImage 设置背景图片
     2.没有图时，使用 navBar.barTintColor 但是这里由于系统处理，内部有多个背景View，层级为内部类，使用不方便，具体机制不清楚
     3.navBar.tintColor 设置的是导航 left/right item 等颜色
     4.navBar.backgroundColor 设置导航bar 的背景的颜色，这里是不包含 statusbar 的部分！
     */
    
}

- (void)setEdgePopGestureEnable:(BOOL)enable
{
    _edgePan.enabled = enable;
}


static UIPanGestureRecognizer *_edgePan;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIPanGestureRecognizer *edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:) ];
    edgePan.delegate = self;
    [self.view addGestureRecognizer:edgePan];
    _edgePan = edgePan;
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1; // 有自控制器的时候恢复返回手势
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
