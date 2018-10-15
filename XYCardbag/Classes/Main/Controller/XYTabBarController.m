//
//  XYTabBarController.m
//  XYCardbag
//
//  Created by xiaoyou on 2017/12/18.
//  Copyright © 2017年 xiaoyou. All rights reserved.
//

#import "XYTabBarController.h"
#import "XYContactsListController.h"
#import "XYNetAccountController.h"
#import "XYIdentitiesController.h"
#import "XYBankCardController.h"
#import "XYTabBar.h"
#import "XYNavigationController.h"

@interface XYTabBarController ()

@end

@implementation XYTabBarController


// 设置item 的 apperence
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = nil;
    
    if (@available(iOS 9.0, *)) {
        item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    } else {// 适配iOS 9 以下系统
        item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    }
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];

    [self setupChildViewControllers];
}


- (void)setupTabBar
{
    // 替换自己tabbar
    XYTabBar *tabbar = [[XYTabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    
}

- (void)setupChildViewControllers
{
    // 加载自控制器
    XYContactsListController *contactVc = [[XYContactsListController alloc] init];
    [self setupChildVC:contactVc title:@"联系人" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
    XYNetAccountController *netAccountVc = [[XYNetAccountController alloc] init];
    [self setupChildVC:netAccountVc title:@"网络账户" imageName:@"temp@2x.png" selectedImageName:@"temp@2x.png"];
    
    XYIdentitiesController *identitiesVc = [[XYIdentitiesController alloc] init];
    [self setupChildVC:identitiesVc title:@"身份信息" imageName:@"temp" selectedImageName:@"temp"];
    
    XYBankCardController *bankCardVc = [[XYBankCardController alloc] init];
    [self setupChildVC:bankCardVc title:@"银行卡" imageName:@"temp@2x.png" selectedImageName:@"temp@2x.png"];
}


- (void)setupChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    // childVc
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    // nav
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    self.tabBar.tintColor = [UIColor redColor];
}



@end
