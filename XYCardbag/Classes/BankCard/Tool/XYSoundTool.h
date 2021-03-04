//
//  XYSoundTool.h
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/4.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

//  一个播放音效的工具
/*
 主要有五个音效
 卡片左滑 <- swipe
 卡片右滑 <- flip
 卡片长按 <- long_press
 拷贝卡片信息 <- copy
 点击各个cell <- tap
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SoundType) {
    SoundTypeSwipeLeft,
    SoundTypeSwipeRight,
    SoundTypeLongPress,
    SoundTypeCopy,
    SoundTypeTap
};

@interface XYSoundTool : NSObject

+ (void)playSoundForType:(SoundType)type;

@end

NS_ASSUME_NONNULL_END
