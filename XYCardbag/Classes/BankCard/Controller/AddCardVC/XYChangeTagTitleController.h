//
//  XYChangeTagTitleController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/23.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeTitleBlock)(BOOL success);

@class XYCardInfoModel;
@interface XYChangeTagTitleController : UIViewController

@property(nonatomic , strong)     XYCardInfoModel *tag;
@property(nonatomic , copy)     ChangeTitleBlock changeTitleBlock;


@end

NS_ASSUME_NONNULL_END
