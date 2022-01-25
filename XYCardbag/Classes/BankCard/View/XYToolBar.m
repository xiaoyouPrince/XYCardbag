//
//
//  XYToolBar.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/5.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYToolBar.h"
#import "Masonry.h"

@interface XYToolBarButtoon : UIButton


/**
 快速创建 XYToolBarButtoon

 @param image image
 @param title title
 @param target target
 @param action action
 @return XYToolBarButtoon
 */
- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;

@end

@implementation XYToolBarButtoon

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action
{
    self = [super init];
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self sizeToFit];
    return self;
}

@end

@interface XYToolBar()

@property(nonatomic , strong) CallbackHandler handler;

@end

@implementation XYToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.85];
    }
    return self;
}


- (instancetype)instanceWithLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage callbackHandler:(CallbackHandler)handler{
    
    if (self == [super init]) {
        
        UIImage *imageLeft = [[UIImage imageNamed:leftImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imageRight = [[UIImage imageNamed:rightImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        XYToolBarButtoon *leftItem = [[XYToolBarButtoon alloc] initWithImage:imageLeft title:nil target:self action:@selector(itemClick:)];
        leftItem.tag = XYToolbarItemPositionLeft;
        
        XYToolBarButtoon *midItem = [[XYToolBarButtoon alloc] initWithImage:nil title:title target:self action:@selector(itemClick:)];
        midItem.tag = XYToolbarItemPositionMiddle;
        
        XYToolBarButtoon *rightItem = [[XYToolBarButtoon alloc] initWithImage:imageRight title:nil target:self action:@selector(itemClick:)];
        rightItem.tag = XYToolbarItemPositiondRight;
        
        [self addSubview:leftItem];
        [self addSubview:midItem];
        [self addSubview:rightItem];
        
        CGFloat itemTop = iPhoneX ? 10 : 5;
        CGFloat itemMargin = 20;
        
        [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(itemTop);
            make.left.equalTo(self).offset(itemMargin);
        }];
        
        [midItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(leftItem);
        }];
        
        [rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(itemTop);
            make.right.equalTo(self).offset(-itemMargin);
        }];
        
        
        self.handler = handler;
        
    }
    return self;
}


- (instancetype)initWithLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage callbackHandler:(CallbackHandler)handler
{
    self = [super init];
    return [self instanceWithLeftImage:leftImage title:title rightImage:rightImage callbackHandler:handler];
    
}

- (void)itemClick:(XYToolBarButtoon *)item{
    if (self.handler) {
        self.handler(item);
    }
}


@end

@implementation XYToolBar (rmImage)
- (void)rmImageBtns{
    for (UIView *subView in self.subviews) {
        if (subView.tag == XYToolbarItemPositionLeft) {
            subView.hidden = YES;
        }
        
        if (subView.tag == XYToolbarItemPositiondRight) {
            subView.hidden = YES;
        }
    }
}
@end
