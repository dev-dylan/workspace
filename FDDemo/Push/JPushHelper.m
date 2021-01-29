//
//  JPushHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "JPushHelper.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

#endif

@interface JPushHelper () <JPUSHRegisterDelegate>

@property (nonatomic, assign) BOOL enable;

@end

@implementation JPushHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static JPushHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[JPushHelper alloc] init];
    });
    return helper;
}

#pragma mark - public method
+ (void)handleRemoteNotification:(NSDictionary *)userInfo {
    if (![[JPushHelper sharedInstance] enable]) {
        return;
    }
    [JPUSHService handleRemoteNotification:userInfo];
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    if (![[JPushHelper sharedInstance] enable]) {
        return;
    }
    [JPUSHService registerDeviceToken:deviceToken];
}

+ (void)startJPush:(NSDictionary *)launchOptions {
    [[JPushHelper sharedInstance] startJPush:launchOptions];
}

+ (void)registerRemoteNotification {
    [[JPushHelper sharedInstance] registerRemoteNotification];
}

#pragma mark - private method
- (void)startJPush:(NSDictionary *)launchOptions {

    _enable = YES;
    [self registerRemoteNotification];

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound | JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
      // 可以添加自定义 categories
      // NSSet<UNNotificationCategory *> *categories for iOS10 or later
      // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值z
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:@"dc0c889d015e8e265d5f3bdc"
                          channel:@"AppStore"
                 apsForProduction:NO
            advertisingIdentifier:advertisingId];

    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"========= registrationID: %@", registrationID);
        // 141fe1da9e17f8c515d
    }];
}

- (void)registerRemoteNotification {
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    // iOS8系统以下
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
  // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPushHelper handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
  // Required
    NSLog(@"极光推送回调：didReceiveNotificationResponse");
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {

}


@end
