//
//  XYChooseRemindDayController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/25.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseDayBlock)(NSString *result);

NS_ASSUME_NONNULL_BEGIN

@interface XYChooseRemindDayController : UITableViewController

@property(nonatomic , copy)     NSString *defaultDay;
@property(nonatomic , copy)     ChooseDayBlock chooseDayBlock;

@end

NS_ASSUME_NONNULL_END
