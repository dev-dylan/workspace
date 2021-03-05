//
//  AppDelegate.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/6/17.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#define BUNDLE_ID com.pengyuanyang.demo
#define COMPANY_BUNDLE_ID com.pengyuanyang.fddemo

#import "AppDelegate.h"

// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "FDSwizzle.h"
#import "FDUniAppHelper.h"
#import "TrackingIOHelper.h"
#import <StoreKit/SKAdNetwork.h>
#import "BUADHelper.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) NSPredicate *regexTestName;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) dispatch_queue_t queue;
@property (nonatomic, assign) NSInteger num;

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Log Class Methods
//    [CommonUtil LogCurrentClassMethods:self];

//    [TrackingIOHelper start];

    // 穿山甲
    [BUADHelper setup];

    // 神策 SDK
    [SAHelper setupSensorsAnalytics:launchOptions];

    // uni MP SDK
//    [FDUniAppHelper initSDKEnvironmentWithLaunchOptions:launchOptions];


    // GIO SDK
//    [GIOHelper setupGrowingIO];

    // 极光 SDK
//    [JPushHelper startJPush:launchOptions];

    //个推 SDK
//    [GPushHelper setupGTSDK];
    
    // LinkedMe SDK
//    [[LinkedMeHelper sharedInstance] setupLinkedMe:launchOptions];

    return YES;
}

#pragma mark - Open URL
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([FDUniAppHelper application:app openURL:url options:options]) {
        return YES;
    }
    if ([SAHelper canOpenURL:url]) {
        return YES;
    }
    if ([GIOHelper handleURL:url]) {
         return YES;
    }
    if ([[LinkedMeHelper sharedInstance] canOpenSchemeURL:url]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if ([FDUniAppHelper application:application continueUserActivity:userActivity restorationHandler:restorationHandler]) {
        return YES;
    }
    if ([SAHelper canOpenURL:userActivity.webpageURL]) {
        return YES;
    }
    if ([[LinkedMeHelper sharedInstance] canOpenUniversalURL:userActivity]) {
        return YES;
    }
    return YES;
}

#pragma mark - Push Nitification
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self getDeviceTokenString:deviceToken];
    [JPushHelper registerDeviceToken:deviceToken];
//    [GPushHelper registerDeviceTokenData:deviceToken];
}

- (void)getDeviceTokenString:(NSData *)deviceToken {
    NSMutableString *deviceTokenString1 = [NSMutableString string];
    const char *bytes = deviceToken.bytes;
    int iCount = (int)deviceToken.length;
    for (int i = 0; i < iCount; i++) {
        [deviceTokenString1 appendFormat:@"%02x", bytes[i]&0x000000FF];
    }
    NSLog(@"deviceToken：%@", deviceTokenString1);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPushHelper handleRemoteNotification:userInfo];
    NSLog(@"收到远程通知 iOS7 ~ NEW ----%@", userInfo);
//    [GPushHelper handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required, For systems with less than or equal to iOS 6
    NSLog(@"收到远程通知 iOS3 ~ iOS10 ----%@", userInfo);
    [JPushHelper handleRemoteNotification:userInfo];
//    [GPushHelper handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 检查当前用户是否允许通知,如果允许就调用 registerForRemoteNotifications
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [application registerForRemoteNotifications];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册远程通知失败----%@", error.localizedDescription);
}

@end
