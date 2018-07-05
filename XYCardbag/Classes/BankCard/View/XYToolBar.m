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

@interface XYToolBar()

@property(nonatomic , strong) CallbackHandler handler;

@end

@implementation XYToolBar

- (instancetype)init
{
    if (self == [super init]) {
        
    }
    return self;
}

- (instancetype)initWithLeftImage:(NSString *)leftImage title:(NSString *)title rightImage:(NSString *)rightImage callbackHandler:(CallbackHandler)handler
{
    if (self == [super init]) {
        
        UIImage *imageLeft = [[UIImage imageNamed:leftImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imageRight = [[UIImage imageNamed:rightImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:imageLeft style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        leftItem.tag = XYToolbarItemPositionLeft;
        
        UIBarButtonItem *flexLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *midItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        midItem.tag = XYToolbarItemPositionMiddle;
        
        UIBarButtonItem *flexRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:imageRight style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        rightItem.tag = XYToolbarItemPositiondRight;
        
        self.items = @[leftItem,flexLeft,midItem,flexRight,rightItem];
        
        self.handler = handler;
    }
    return self;
}

- (void)itemClick:(UIBarButtonItem *)item{
    if (self.handler) {
        self.handler(item);
    }
}


@end
