//
//
//  XYCardInfoModel.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYCardInfoModel.h"

@implementation XYCardInfoModel
MJCodingImplementation;

- (NSString *)tagString
{
    // 基于 tagType 来定义的，自定义的标签中的类型string
    switch (self.tagType) {
        case TagTypeBaseImage:
        case TagTypeBaseName:
        case TagTypeBaseNumber:
        case TagTypeBaseDesc:
            return @"基础标签";// 这几类不用管
            break;
        case TagTypeDate:
            return @"日期";
            break;
        case TagTypePhoneNumber:
            return @"电话";
            break;
        case TagTypeMail:
            return @"邮件";
            break;
        case TagTypeNetAddress:
            return @"网址";
            break;
        case TagTypeCustom:
            return @"其他";
            break;
        case TagTypeAdd:
            return @"站位";
            break;
            
        default:
            break;
    }
}

+ (instancetype)cardinfoWithTagString:(NSString *)str{
    
    XYCardInfoModel *instance = [XYCardInfoModel new];
    if ([str isEqualToString:@"日期"]) {
        instance.tagType = TagTypeDate;
    }
    if ([str isEqualToString:@"电话"]) {
        instance.tagType = TagTypePhoneNumber;
    }
    if ([str isEqualToString:@"邮件"]) {
        instance.tagType = TagTypeMail;
    }
    if ([str isEqualToString:@"网址"]) {
        instance.tagType = TagTypeNetAddress;
    }
    if ([str isEqualToString:@"其他"]) {
        instance.tagType = TagTypeCustom;
    }else{
        instance.tagType = TagTypeCustom; // 不符合的都设置为这个
    }
    
    return instance;
}

+ (TagType)tagTypeWithTagString:(NSString *)str{
    
    if ([str isEqualToString:@"日期"]) {
        return TagTypeDate;
    }
    if ([str isEqualToString:@"电话"]) {
        return TagTypePhoneNumber;
    }
    if ([str isEqualToString:@"邮件"]) {
        return TagTypeMail;
    }
    if ([str isEqualToString:@"网址"]) {
        return TagTypeNetAddress;
    }
    if ([str isEqualToString:@"其他"]) {
        return TagTypeCustom;
    }
    
    return TagTypeCustom;
}

// 这里的代码有什么问题？ 没有释放observer?? 退出页面直接崩溃。。。不报错直接崩

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
//    }
//    return self;
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    NSLog(@"old is %@",change[NSKeyValueChangeOldKey]);
//    NSLog(@"old is %@",change[NSKeyValueChangeNewKey]);
//}
//
//- (void)setTitle:(NSString *)title
//{
//    _title = title;
//
//    NSLog(@"title = %@",title);
//}
//
//- (void)dealloc{
//    [self removeObserver:self forKeyPath:@"title"];
//}
//
//- (NSString *)description{
//    return [NSString stringWithFormat:@"tag.type = %lu , tag.title = %@ , tag.detail = %@",(unsigned long)self.tagType , self.title,self.detail];
//}


@end
