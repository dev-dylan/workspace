//
//  GPushHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "GPushHelper.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#if __has_include(<GTSDK/GeTuiSdk.h>)
#import <GTSDK/GeTuiSdk.h>     // GetuiSdk头文件应用

@interface GPushHelper () <GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

@end

@implementation GPushHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static GPushHelper* helper;
    dispatch_once(&onceToken, ^{
        helper = [[GPushHelper alloc] init];
    });
    return helper;
}

+ (void)setupGTSDK {
    [[GPushHelper sharedInstance] setupGTSDK];
}

+ (void)registerRemoteNotification {
    [[GPushHelper sharedInstance] registerRemoteNotification];

}

- (void)setupGTSDK {
    [GeTuiSdk startSdkWithAppId:@"yV2lNMQL0x9lxAO6B8wuu8" appKey:@"tc1dSLy3Kc7gU7vr7BAOo6" appSecret:@"H6CFhtxzTr6VxDBMfXTHaA" delegate:self];
    [self registerRemoteNotification];
}

- (void)registerRemoteNotification {
    float iOSVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (iOSVersion >= 10.0) {
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
                if (!error && granted) {
                    NSLog(@"[ TestDemo ] iOS request authorization succeeded!");
                }
            }];
        } else {
            // Fallback on earlier versions
        }
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        return;
    }

    if (iOSVersion >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

+ (void)registerDeviceTokenData:(NSData *)deviceToken {
    [GeTuiSdk registerDeviceTokenData:deviceToken];
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo {
    [GeTuiSdk handleRemoteNotification:userInfo];
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    // dylan: 23349737206369a17b269e8254a951ac
    // 6s: c90532baf25070eef9d86458157f730c
}

@end

#else

@implementation GPushHelper

+ (void)setupGTSDK{}
+ (void)registerDeviceTokenData:(NSData *)deviceToken{}
+ (void)handleRemoteNotification:(NSDictionary *)userInfo{}
+ (void)registerRemoteNotification{}

@end

#endif
