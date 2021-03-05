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

@class XYBankCardSection;
@protocol BankCardBgVCDelegate<NSObject>
@optional
- (void)backgroundView:(UIView *)bgView isEditing:(BOOL)isEdit;
- (void)backgroundView:(UIView *)bgView didChooseSection:(XYBankCardSection *)section;

@end

@interface XYBankCardBgViewController : UIViewController//UITableViewController

@property(nonatomic,weak) id<BankCardBgVCDelegate> delegate;
@end
