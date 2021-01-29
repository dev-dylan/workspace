//
//  GPushHelper.h
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPushHelper : NSObject

+ (void)setupGTSDK;
+ (void)registerDeviceTokenData:(NSData *)deviceToken;
+ (void)handleRemoteNotification:(NSDictionary *)userInfo;
+ (void)registerRemoteNotification;
@end

NS_ASSUME_NONNULL_END
