//
//  XYClockView.m
//  XYCardbag
//
//  Created by 渠晓友 on 2021/3/3.
//  Copyright © 2021 xiaoyou. All rights reserved.
//

#import "XYClockView.h"

@implementation XYClockView

+ (instancetype)sharedInstance{
    static XYClockView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent{
    XYFunc
}

@end
