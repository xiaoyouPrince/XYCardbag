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

typedef enum : NSUInteger {
    XYToolbarItemPositionLeft = 0x01,
    XYToolbarItemPositionMiddle,
    XYToolbarItemPositiondRight
} XYToolbarItemPosition;

typedef void(^CallbackHandler)(UIButton *btn);

@interface XYToolBar : UIView // UIToolbar <适配 iPhone X 以上机型，系统会自动调整 item 位置>

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

@interface XYToolBar (rmImage)
- (void)rmImageBtns;
@end
