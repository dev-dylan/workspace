//
//  FDUniAppHelper.h
//  FDDemo
//
//  Created by 彭远洋 on 2021/1/6.
//  Copyright © 2021 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDUniAppHelper : NSObject

+ (void)initSDKEnvironmentWithLaunchOptions:(NSDictionary *)launchOptions;

+ (void)applicationDidBecomeActive:(UIApplication *)application;

+ (void)applicationWillResignActive:(UIApplication *)application;

+ (void)applicationDidEnterBackground:(UIApplication *)application;

+ (void)applicationWillEnterForeground:(UIApplication *)application;

+ (void)applicationWillTerminate:(UIApplication *)application;

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

+ (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler;

+ (void)openUniMP;

@end

NS_ASSUME_NONNULL_END
