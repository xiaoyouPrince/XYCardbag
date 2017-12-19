//
//  UIImage+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/9.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYAdd)


/**
 根据图片名返回渲染的原图

 @param imageName 图片名
 @return 渲染的原图
 */
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

/**
 *  返回一张适配后的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resiedImageWithName:(NSString *)name;


/**
 返回一张根据左上边距拉伸的图片

 @param name 图片名
 @param left 左边比例
 @param top 上边比例
 @return 拉伸后的图
 */
+ (UIImage *)resiedImageWithName:(NSString *)name left:(CGFloat )left top:(CGFloat)top;


/**
 根据颜色生成一张图片

 @param color 颜色
 @return 1*1 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 根据图片名返回对应的圆角图片

 @param name 图片名
 @return 圆角图片
 */
+ (UIImage *)circleImageNamed:(NSString *)name;
- (instancetype)circleImage;

@end
