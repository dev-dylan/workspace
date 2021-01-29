//
//  TrackingIOHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2021/1/27.
//  Copyright © 2021 Sensors Data Inc. All rights reserved.
//

#import "TrackingIOHelper.h"
#import "Tracking.h"
#import "CAID.h"

@interface TrackingIOHelper () <CAIDUpdateProtocol>

@end

@implementation TrackingIOHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TrackingIOHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [TrackingIOHelper new];
    });
    return helper;
}

+ (void)start {
    [[TrackingIOHelper sharedInstance] start];
}

- (void)start {
    [Tracking initWithAppKey:@"f4c6764d10bec9a3c4bd4f79a442a947" withChannelId:@"_default_"];
    [Tracking setCAIDUpdateCallbackDelegate:self];

    NSString *deviceId = [Tracking getDeviceId];
    NSString *caid = [Tracking getCachedCaid];
    NSString *currentId = [Tracking getCurrentCaid];
    NSLog(@"\n ####################\n deviceId: %@; \n caid: %@; \n currentId: %@; \n ####################", deviceId, caid, currentId);
}

- (void)onCAIDUpdateCalllback:(NSString *)caid {
    NSString *deviceId = [Tracking getDeviceId];
    NSString *currentId = [Tracking getCurrentCaid];
    NSLog(@"\n ####################\n deviceId: %@; \n caid: %@; \n currentId: %@; \n ####################", deviceId, caid, currentId);
}

@end
