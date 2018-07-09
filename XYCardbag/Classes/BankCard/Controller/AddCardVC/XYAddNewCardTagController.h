//
//
//  XYAddNewCardTagController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  逻辑:
//  用户进来，选择要添加的内容即可。页面 didDisappear 之后通过block把添加的类型Model传给前面，前页可在页面 didAppear之后进行刷新展示

#import <UIKit/UIKit.h>
#import "XYCardInfoModel.h"

typedef void(^AddTagBlock)(XYCardInfoModel *model);

@interface XYAddNewCardTagController : UIViewController

@property(nonatomic , strong) AddTagBlock addTagBlock;


@end
