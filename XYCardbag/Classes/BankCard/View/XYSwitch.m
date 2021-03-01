//
//  XYSwitch.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/1.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYSwitch.h"

@implementation XYSwitch

- (instancetype)init
{
    if (self = [super init]) {
        [self addTarget:self action:@selector(changeSeting:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)changeSeting:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:self.settingKey];
}

@end
