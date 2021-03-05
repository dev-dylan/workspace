//
//  SceneDelegate.m
//  ListClickDemo
//
//  Created by 彭远洋 on 2020/11/4.
//

#import "SceneDelegate.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    NSUserActivity *user = connectionOptions.userActivities.allObjects.firstObject;
    UIOpenURLContext *urlContext = connectionOptions.URLContexts.allObjects.firstObject;
    [self initSASDK:connectionOptions];
}

- (void)initSASDK:(id)launchOptions {
    SAConfigOptions *options = [[SAConfigOptions alloc] initWithServerURL:@"https://newsdktest.datasink.sensorsdata.cn/sa?project=pengyuanyang&token=5a394d2405c147ca" launchOptions:launchOptions];
    options.autoTrackEventType = SensorsAnalyticsEventTypeAppStart | SensorsAnalyticsEventTypeAppEnd | SensorsAnalyticsEventTypeAppClick | SensorsAnalyticsEventTypeAppViewScreen;
    options.enableLog = YES;
    options.enableVisualizedAutoTrack = YES;
    options.enableHeatMap = YES;
    [SensorsAnalyticsSDK startWithConfigOptions:options];
    [[SensorsAnalyticsSDK sharedInstance] enableTrackGPSLocation:YES];
}

-(void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    UIOpenURLContext *urlContext = URLContexts.allObjects.firstObject;
    if ([[SensorsAnalyticsSDK sharedInstance] canHandleURL:urlContext.URL]) {
        [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:urlContext.URL];
    }
}

- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity {
    if ([[SensorsAnalyticsSDK sharedInstance] canHandleURL:userActivity.webpageURL]) {
        [[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:userActivity.webpageURL];
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
