//
//  UIImage+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/9.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "UIImage+XYAdd.h"

@implementation UIImage (XYAdd)

/// 根据图片名返回渲染的原图<XIB中可以复选UIImage选择渲染原图>
+ (UIImage *)imageOriginalWithName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        // 如果是iOS7 拼接图片
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        
        if (image == nil) {
            // 如果没有 iOS7 的图片就用原来图片名
            image = [UIImage imageNamed:name];
        }
        // 返回该图片
        return image;
    }
    
    // 非iOS7
    return [UIImage imageNamed:name];
}

+ (UIImage *)resiedImageWithName:(NSString *)name
{
    return [self resiedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resiedImageWithName:(NSString *)name left:(CGFloat )left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}


/**
 返回一张圆角图片

 @return 圆角图片
 */
- (instancetype)circleImage
{
    // 1.开启图形上下文
    // 比例因素:当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁剪区域;
    [path addClip];
    // 4.画图片
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 根据图片名返回对应的圆角图片
 
 @param name 图片名
 @return 圆角图片
 */
+ (UIImage *)circleImageNamed:(NSString *)name
{
    return [[[self alloc] init] circleImage];
}

@end
