//
//  XYContactsDetailController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/1/18.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYContacts.h" ///联系人信息

@interface XYContactsDetailController : UITableViewController

/// 联系人姓名
@property(nonatomic , copy) NSString *conName;
/// 联系人信息
@property(nonatomic , strong) XYContacts  *contact;

@end
