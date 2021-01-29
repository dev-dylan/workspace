//
//  GIOHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "GIOHelper.h"
#import <Growing/Growing.h>

@implementation GIOHelper

static BOOL enable = NO;

+ (void)setupGrowingIO {
    // 启动GrowingIO
    enable = YES;
    [Growing startWithAccountId:@"810b7d58f6291f4d"];      // 替换为您的项目ID
    [Growing setEnableLog:YES];
    [Growing setFlushInterval:1];
    //开启推送点击采集
    [Growing disablePushTrack:NO];
}

+ (BOOL)handleURL:(NSURL *)url {
    // 请务必确保该函数被调用
    if (!enable) {
        return NO;
    }
    return [Growing handleUrl:url];
}

@end
