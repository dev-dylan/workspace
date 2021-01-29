//
//  FDUniAppHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2021/1/6.
//  Copyright © 2021 Sensors Data Inc. All rights reserved.
//

#import "FDUniAppHelper.h"
#import "DCUniMP.h"
#import "WXSDKEngine.h"

@implementation FDUniAppHelper

+ (void)initSDKEnvironmentWithLaunchOptions:(NSDictionary *)launchOptions {
    // 配置参数
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
    // 设置 debug YES 会在控制台输出 js log，默认不输出 log，注：需要引入 liblibLog.a 库
    [options setObject:[NSNumber numberWithBool:YES] forKey:@"debug"];
    // 初始化引擎
    [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:options];

    [WXSDKEngine registerModule:@"MDAnalyticsModule" withClass:NSClassFromString(@"MDAnalyticsModule")];
    [FDUniAppHelper checkUniMPResource];
}

#pragma mark - App 生命周期方法
+ (void)applicationDidBecomeActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidBecomeActive:application];
}

+ (void)applicationWillResignActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillResignActive:application];
}

+ (void)applicationDidEnterBackground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidEnterBackground:application];
}

+ (void)applicationWillEnterForeground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillEnterForeground:application];
}

+ (void)applicationWillTerminate:(UIApplication *)application {
    [DCUniMPSDKEngine destory];
}

static NSString *k_AppId = @"__UNI__8DD0904";
/// 检查运行目录是否存在应用资源，不存在将应用资源部署到运行目录
+ (void)checkUniMPResource {
    // 注意：isExistsApp: 方法仅是判断运行目录中是否存在应用资源，正式环境应该添加版本控制，内置新的wgt资源后需要判断版本，决定是否需要释放应用资源
    if (![DCUniMPSDKEngine isExistsApp:k_AppId]) {
        // 读取导入到工程中的wgt应用资源
        NSString *appResourcePath = [[NSBundle mainBundle] pathForResource:k_AppId ofType:@"wgt"];
        // 将应用资源部署到运行路径中
        if ([DCUniMPSDKEngine releaseAppResourceToRunPathWithAppid:k_AppId resourceFilePath:appResourcePath]) {
            NSLog(@"应用资源文件部署成功");
        }
    }
}

+ (void)openUniMP {
    // 初始化小程序的配置信息对象
    DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
    [DCUniMPSDKEngine openUniMP:k_AppId configuration:configuration completed:^(DCUniMPInstance * _Nullable uniMPInstance, NSError * _Nullable error) {
        if (uniMPInstance) {
            // success
        } else {
            // error
        }
    }];
}

#pragma mark - 如果需要使用 URL Scheme 或 通用链接相关功能，请实现以下方法
+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 通过 url scheme 唤起 App
    [DCUniMPSDKEngine application:app openURL:url options:options];
    return YES;
}

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    // 通过通用链接唤起 App
    [DCUniMPSDKEngine application:application continueUserActivity:userActivity];
    return YES;
}

@end
