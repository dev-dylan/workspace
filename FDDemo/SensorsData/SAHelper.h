//
//  SensorsHelper.h
//  FDDemo
//
//  Created by 彭远洋 on 2019/10/24.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAHelper : NSObject

+ (void)setupSensorsAnalytics:(NSDictionary *)launchOptions;
+ (void)track:(NSString *)event properties:(NSDictionary *)properties;
+ (void)trackViewScreen:(UIViewController *)controller properties:(NSDictionary *)properties;

+ (BOOL)canOpenURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
