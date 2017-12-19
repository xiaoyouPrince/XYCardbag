//
//  UITextField+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//
//  使用runtime来设置textField的站位文字颜色

#import "UITextField+XYAdd.h"
#import <objc/message.h>

@implementation UITextField (XYAdd)


+ (void)load
{
    // 交换自己和系统的方法
    Method setplaceHolderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method set_xy_placeHolderMethod = class_getInstanceMethod(self, @selector(set_xy_placeHolder:));
    method_exchangeImplementations(setplaceHolderMethod, set_xy_placeHolderMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 绑定颜色属性到原来类中
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
    
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)set_xy_placeHolder:(NSString *)placeHolder
{
    [self set_xy_placeHolder:placeHolder];
    
    self.placeholderColor = self.placeholderColor;
}

@end
