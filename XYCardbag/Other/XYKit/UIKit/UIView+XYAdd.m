//
//  UIView+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "UIView+XYAdd.h"

@implementation UIView (XYAdd)


#pragma mark --- frame相关
- (void)setXy_x:(CGFloat)xy_x
{
    CGRect frame = self.frame;
    frame.origin.x = xy_x;
    self.frame = frame;
}

- (CGFloat)xy_x
{
    return self.frame.origin.x;
}

- (void)setXy_y:(CGFloat)xy_y
{
    CGRect frame = self.frame;
    frame.origin.y = xy_y;
    self.frame = frame;
}

- (CGFloat)xy_y
{
    return self.frame.origin.y;
}

- (void)setXy_centerX:(CGFloat)xy_centerX
{
    CGPoint center = self.center;
    center.x = xy_centerX;
    self.center = center;
}

- (CGFloat)xy_centerX
{
    return self.center.x;
}

- (void)setXy_centerY:(CGFloat)xy_centerY
{
    CGPoint center = self.center;
    center.y = xy_centerY;
    self.center = center;
}


- (CGFloat)xy_centerY
{
    return self.center.y;
}

- (void)setXy_width:(CGFloat)xy_width
{
    CGRect frame = self.frame;
    frame.size.width = xy_width;
    self.frame = frame;
}

- (CGFloat)xy_width
{
    return self.frame.size.width;
}

- (void)setXy_height:(CGFloat)xy_height
{
    CGRect frame = self.frame;
    frame.size.height = xy_height;
    self.frame = frame;
}

- (CGFloat)xy_height
{
    return self.frame.size.height;
}

- (void)setXy_origin:(CGPoint)xy_origin
{
    CGRect frame = self.frame;
    frame.origin = xy_origin;
    self.frame = frame;
}

- (CGPoint)xy_origin
{
    return self.frame.origin;
}

- (void)setXy_size:(CGSize)xy_size
{
    CGRect frame = self.frame;
    frame.size = xy_size;
    self.frame = frame;
}

- (CGSize)xy_size
{
    return self.frame.size;
}
#pragma mark --- frame相关



@end
