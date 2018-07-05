//
//
//  XYToolBar.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/5.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
/*
 
    UIToolBar 层次
 
 第一层两个subView:           _UIBarBackground
                            _UIToolbarContentView
 
 第二层_UIToolbarContentView 中有一个stackView层
                            _UIButtonBarStackView
 
 第三层 _UIButtonBarStackView 中才是最后排列的几个itemView
 */

#import <UIKit/UIKit.h>

typedef void(^CallbackHandler)(UIBarButtonItem *item);

@interface XYToolBar : UIToolbar

/**
 快速创建项目中三个功能的toolbar

 @param leftImage 左边item的图片
 @param title 中间item标题
 @param rightImage 左边item的图片
 @param handler item 点击回调
 @return toolBar
 */
- (instancetype)initWithLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage callbackHandler:(CallbackHandler)handler;

@end
