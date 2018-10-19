//
//  XYAddCustomTagCell.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/10/19.
//  Copyright © 2018年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYCardInfoModel.h"

/// 用户选择自定义 tag 之后发送通知给前页面，保存选择的tagModel
FOUNDATION_EXPORT NSString *const DidChooseCustomTagNotification;

NS_ASSUME_NONNULL_BEGIN

@interface XYAddCustomTagCell : UITableViewCell

/**
 内部自动返回cell高度
 */
@property(nonatomic , assign , readonly)   CGFloat cellHeight;

/**
 快速创建一个选择自定义tag的Cell

 @param tableview 源tableview
 @return cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableview;

/**
 用户最终自定完的包含卡片 tagType 和 title 的cardInfo
 */
@property(nonatomic , strong , readonly)     XYCardInfoModel *customCardnfo;

@end

NS_ASSUME_NONNULL_END
