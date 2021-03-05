//
//  SensorsHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/10/24.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "SAHelper.h"
#import "SAPermissions.h"
//#import "CAID.h"

#if __has_include("SensorsAnalyticsSDK.h")
#import "SensorsAnalyticsSDK.h"

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

static void (*orig_NSLog)(NSString *format, ...);
void(new_NSLog)(NSString *format, ...) {
    va_list args;
    if(format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        orig_NSLog(@"%@", message);
        va_end(args);
    }
}

// 初始化方法里进行替换
+ (void)setupSensorsAnalytics:(NSDictionary *)launchOptions {
//    rebind_symbols((struct rebinding[1]){{"NSLog", new_NSLog, (void *)&orig_NSLog}}, 1);
    enable = YES;

    SAConfigOptions *configOptions = [[SAConfigOptions alloc]initWithServerURL:Sa_Default_ServerURL launchOptions:launchOptions];
    configOptions.autoTrackEventType = -4;
    configOptions.enableTrackAppCrash = YES;
    configOptions.disableRandomTimeRequestRemoteConfig = YES;
//    configOptions.enableHeatMap = YES;
//
//    configOptions.enableVisualizedAutoTrack = YES;
//    configOptions.enableAutoAddChannelCallbackEvent = YES;
    configOptions.enableLog = YES;
//    configOptions.enableTrackPush = YES;
//    configOptions.enableEncrypt = YES;
//    configOptions.enableSaveUtm = YES;
//    configOptions.sourceChannels = @[@"key1", @"key2"];
//    configOptions.sourceChannels = @[@"key3", @"key4"];


    [SensorsAnalyticsSDK startWithConfigOptions:configOptions];
    SensorsAnalyticsSDK *sdk = [SensorsAnalyticsSDK sharedInstance];
//    [sdk enableLog:YES];
//    [sdk identify:@"AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"];
    [sdk registerSuperProperties:NULL];
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
//    [SAPermissions userTrackingAuthorization:^(NSString * _Nonnull idfa) {
//        NSDictionary *caidInfo = @{@"caid1":@"xxx111", @"version1":@20200901, @"lastCaid1":@"xxx222", @"lastCaidVersion1":@20201201};
//        [[SensorsAnalyticsSDK sharedInstance] trackInstallation:@"AppInstall" withProperties:@{@"sensorsAnalyticsCaidInfo":caidInfo}];
//    }];

//    CAID *caid = [CAID initCAID:@"" pubKey:@""];
//    [caid getCAIDAsyncly:^(CAIDError * _Nonnull error, CAIDStruct * _Nonnull caidStruct) {
//        NSDictionary *caidInfo = @{@"caid1":@"xxx111", @"version1":@20200901, @"lastCaid1":@"xxx222", @"lastCaidVersion1":@20201201};
//        [[SensorsAnalyticsSDK sharedInstance] trackInstallation:@"AppInstall" withProperties:@{@"sensorsAnalyticsCaidInfo":caidInfo}];
//    }];

//    [SAPermissions photoLibraryAuthorization:^{
//        NSLog(@"========= photo library authorization !!!!");
//    }];

    [sdk setFlushNetworkPolicy:SensorsAnalyticsNetworkTypeALL];
    [sdk clearKeychainData];

    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("kk", DISPATCH_QUEUE_SERIAL);

    // 防止循环引用 使用 __weak 修饰
    dispatch_async(queue, ^{
//        [sdk enableTrackGPSLocation:YES];
//        [sdk enableTrackScreenOrientation:YES];
    });
}

+ (void)track:(NSString *)event properties:(NSDictionary *)properties {
    if (!enable) {
        return;
    }
    [[SensorsAnalyticsSDK sharedInstance] track:event withProperties:properties];
}

+ (BOOL)canOpenURL:(NSURL *)url {
    if (!enable) {
        return NO;
    }
    if ([[SensorsAnalyticsSDK sharedInstance] canHandleURL:url]) {
        [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:url];
        return YES;
    }
    return NO;
}

+ (void)login:(NSString *)loginId {
    [[SensorsAnalyticsSDK sharedInstance] login:loginId];
}

+ (void)flush {
    [[SensorsAnalyticsSDK sharedInstance] flush];
}

+ (void)profileUnset:(NSString *)key {
    [[SensorsAnalyticsSDK sharedInstance] unset:key];
}

+ (void)trackViewScreen:(UIViewController *)controller properties:(NSDictionary *)properties {
    [[SensorsAnalyticsSDK sharedInstance] trackViewScreen:controller properties:properties];
}

@end

#else

@implementation SAHelper

+ (void)setupSensorsAnalytics:(NSDictionary *)launchOptions{}
+ (void)track:(NSString *)event properties:(NSDictionary *)properties{}
+ (void)trackViewScreen:(UIViewController *)controller properties:(NSDictionary *)properties{}
+ (void)login:(NSString *)loginId{}
+ (void)flush{}
+ (void)profileUnset:(NSString *)key{}
+ (BOOL)canOpenURL:(NSURL *)url{return NO;}

@end
#endif