//
//
//  XYAddCategoryController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/6.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYAddCategoryController : UIViewController
/** 添加分类完成后回调 */
@property (nonatomic, copy)         void(^didSaveNewCategoryBlock)(void);
@end
