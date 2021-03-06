//
//  XYSoundTool.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/4.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

//  一个播放音效的工具

#import "XYSoundTool.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation XYSoundTool

+ (void)playSoundForType:(SoundType)type{
    
    // 检查配置
    if (![kUserDefaults boolForKey:SettingKey_EnableSound]) return;
    BOOL alert = [kUserDefaults boolForKey:SettingKey_EnableSoundWithAlert];
    
    NSString *soundName = nil;
    switch (type) {
        case SoundTypeSwipeLeft:
            soundName = @"swipe";
            break;
        case SoundTypeSwipeRight:
            soundName = @"flip";
            break;
        case SoundTypeLongPress:
            soundName = @"long_press";
            break;
        case SoundTypeCopy:
            soundName = @"copy";
            break;
        case SoundTypeTap:
            soundName = @"tap";
            break;
        case SoundTypeBringTop:
            soundName = @"bring_top";
            break;
        case SoundTypeDelete:
            soundName = @"delete";
            break;
        case SoundTypeStageDone:
            soundName = @"auto_stage_done";
            break;
        default:
            break;
    }
    
    // 播放声音
    if (soundName) {
        playSoundWithName(soundName,alert);
    }
    
}


void playSoundWithName(NSString *soundName, BOOL alert){
    
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:soundName ofType:@"caf"];
    if (!audioFile) {
        audioFile = [[NSBundle mainBundle] pathForResource:soundName ofType:@"aif"];
    }
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
    if (alert) {
        AudioServicesPlayAlertSound(soundID);//播放音效并震动
    }else{
        AudioServicesPlaySystemSound(soundID);//播放音效
    }
}

/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
    //3.销毁声音
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
