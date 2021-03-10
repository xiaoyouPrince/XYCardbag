//
//  XYChooseBankViewController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/10.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYInfomationBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYChooseBankViewController : XYInfomationBaseViewController

/**
 添加卡的类型,内部根据卡片类型进行不同UI的渲染
 */
@property(nonatomic , assign) CardType cardType;
/**
 要保存卡片的sectionID。对应的那个大类
 */
@property(nonatomic , copy) NSNumber * sectionID;

@end

NS_ASSUME_NONNULL_END
