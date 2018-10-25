//
//  XYChooseDateViewController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/25.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYCardInfoModel;
@class XYRemind;
typedef void(^ChooseDateBlock)(XYRemind *remind);

NS_ASSUME_NONNULL_BEGIN

@interface XYChooseDateViewController : UITableViewController

@property(nonatomic , strong)     XYCardInfoModel *tag;
@property(nonatomic , copy)     ChooseDateBlock chooseDateBlock;

@end
NS_ASSUME_NONNULL_END
