//
//  XYNavigationController.h
//  XYCardbag
//
//  Created by xiaoyou on 2017/12/19.
//  Copyright © 2017年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYNavigationController : UINavigationController


/**
 设置页面左滑返回功能是否可用

 @param enable yes/no
 */
- (void)setEdgePopGestureEnable:(BOOL)enable;

@end
