//
//
//  XYBankCardBgViewController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/4.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BankCardBgVCDelegate<NSObject>
@optional
- (void)backgroundView:(UIView *)bgView isEditing:(BOOL)isEdit;

@end

@interface XYBankCardBgViewController : UIViewController//UITableViewController

@property(nonatomic,weak) id<BankCardBgVCDelegate> delegate;
@end
