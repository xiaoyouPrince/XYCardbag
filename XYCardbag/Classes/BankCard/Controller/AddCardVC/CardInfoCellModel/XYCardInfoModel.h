//
//
//  XYCardInfoModel.h
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  关于图片缓存的两种思路<技术选型>  --->  本项目暂时使用方案1
//
//  1.这里的图片存储应该使用data。这样直接存取图片。使用的时候方便
//  2.直接将获取到的图片 以keyValue的形式存到Dictionary中，自己做一个图片的缓存管理。图片缓存模仿SDWebImage


//   卡片图片：
//   一个单独的cell
//   卡片信息：
//   基本信息：名称 + 卡号 + 备注
//   更多卡片信息：共5种类型：日期(提供picker快速选日期功能) + 电话 + 邮件 + 网址 + 其他(后四种主要是键盘不同)  ？？？ 是否可用继承的方式做？



#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    /// 四种基本类型
    TagTypeBaseImage = 0,       // default :  名称 + 卡号 + 备注
    TagTypeBaseName,            // 卡名称
    TagTypeBaseNumber,          // 卡号码
    TagTypeBaseDesc,            // 卡描述
    
    /// 额外几种标签类型
    TagTypeDate,            // 还款日期，有效日期
    TagTypePhoneNumber,     // 电话号码
    TagTypeMail,            // 电话邮件
    TagTypeNetAddress,      // 电话网址
    TagTypeCustom           // 其他，自定义
} TagType;

@interface XYCardInfoModel : NSObject

// 第一个cell的正反面icon
@property(nonatomic , strong) UIImage *frontIconImage;
@property(nonatomic , strong) UIImage *rearIconImage;

/// tag 类型的一些属性
@property(nonatomic , assign) TagType tagType;
/// 自定义类型中的tagSting。tagString根据tagType决定【日期  电话  邮件  网址  其他】共5种
@property(nonatomic , copy , readonly) NSString *tagString;

/// 当前的标签的title --> 这个在用户添加自定义标签的时候可以自定义
@property(nonatomic , copy) NSString *title;
/// 当前的标签的detail --> egg: 卡号(title) : 123456(detail)
@property(nonatomic , copy) NSString *detail;


@end
