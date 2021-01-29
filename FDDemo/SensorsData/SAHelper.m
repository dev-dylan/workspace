//
//  SensorsHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/10/24.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "SAHelper.h"
#import "SAPermissions.h"

#ifdef ENABLE_SENSORS_ANALYTICS
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#endif

static NSString* Sa_Default_ServerURL = @"http://newsdktest.datasink.sensorsdata.cn/sa?project=pengyuanyang&token=5a394d2405c147ca";
static NSString* ChannelDebugURL = @"http://10.120.70.67:8106/sa?project=default";
static NSString* ChannelDebug2URL = @"http://10.120.98.246:8106/sa?project=production";
static NSString* DeepLinkURL = @"https://sachannledata.debugbox.sensorsdata.cn:8106/test/sa?project=default";

//http://10.120.70.67:8106/sa?project=default
//http://10.120.149.211/:8106/sa?project=default
//https://newsdktest.datasink.sensorsdata.cn/sa?project=pengyuanyang&token=5a394d2405c147ca
// @"http://10.120.156.98:8106/sa?project=default"
@implementation SAHelper

static BOOL enable = NO;

+ (void)setupSensorsAnalytics:(NSDictionary *)launchOptions {
#ifdef ENABLE_SENSORS_ANALYTICS
    enable = YES;

    SAConfigOptions *configOptions = [[SAConfigOptions alloc]initWithServerURL:Sa_Default_ServerURL launchOptions:launchOptions];
//    configOptions.autoTrackEventType = SensorsAnalyticsEventTypeAppStart| SensorsAnalyticsEventTypeAppEnd | SensorsAnalyticsEventTypeAppViewScreen | SensorsAnalyticsEventTypeAppClick;
    configOptions.enableTrackAppCrash = YES;
    configOptions.disableRandomTimeRequestRemoteConfig = YES;
//    configOptions.enableHeatMap = YES;
//
//    configOptions.enableVisualizedAutoTrack = YES;
    configOptions.enableAutoAddChannelCallbackEvent = YES;
    configOptions.enableLog = YES;
    configOptions.enableReferrerTitle = YES;
//    configOptions.enableEncrypt = YES;
//    configOptions.enableSaveUtm = YES;
//    configOptions.sourceChannels = @[@"key1", @"key2"];
//    configOptions.sourceChannels = @[@"key3", @"key4"];


    [SensorsAnalyticsSDK startWithConfigOptions:configOptions];
    SensorsAnalyticsSDK *sdk = [SensorsAnalyticsSDK sharedInstance];
//    [sdk enableLog:YES];
//    [sdk identify:@"AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"];
//    [sdk registerSuperProperties:@{@"AAA":[[NSUUID UUID] UUIDString]}];
    [sdk setCookie:@"测试123" withEncode:YES];
//    [sdk registerDynamicSuperProperties:^NSDictionary<NSString *,id> * _Nonnull{
//        __block UIApplicationState appState;
//        if (NSThread.isMainThread) {
//            appState = UIApplication.sharedApplication.applicationState;
//        }else {
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                appState = UIApplication.sharedApplication.applicationState;
//            });
//        }
//        return @{@"__APPState__":@(appState)};
//
//    }];
    [SAPermissions userTrackingAuthorization:^(NSString * _Nonnull idfa) {
        [[SensorsAnalyticsSDK sharedInstance] trackInstallation:@"AppInstall" withProperties:@{}];
    }];

//    [SAPermissions photoLibraryAuthorization:^{
//        NSLog(@"========= photo library authorization !!!!");
//    }];

    [sdk setFlushNetworkPolicy:SensorsAnalyticsNetworkTypeALL];
    [sdk clearKeychainData];

    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("kk", DISPATCH_QUEUE_SERIAL);

    // 防止循环引用 使用 __weak 修饰
    __weak typeof(self)weakSelf = self;
    dispatch_async(queue, ^{
        [sdk enableTrackGPSLocation:YES];
        [sdk enableTrackScreenOrientation:YES];
    });

#endif
}

+ (void)track:(NSString *)event properties:(NSDictionary *)properties {
#ifdef ENABLE_SENSORS_ANALYTICS
    if (!enable) {
        return;
    }
    [[SensorsAnalyticsSDK sharedInstance] track:event withProperties:properties];
#endif
}

+ (BOOL)canOpenURL:(NSURL *)url {
#ifdef ENABLE_SENSORS_ANALYTICS
    if (!enable) {
        return NO;
    }
    if ([[SensorsAnalyticsSDK sharedInstance] canHandleURL:url]) {
        [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:url];
        return YES;
    }
#endif
    return NO;
}

+ (void)trackViewScreen:(UIViewController *)controller properties:(NSDictionary *)properties {
#ifdef ENABLE_SENSORS_ANALYTICS
    [[SensorsAnalyticsSDK sharedInstance] trackViewScreen:controller properties:properties];
#endif

}

@end
