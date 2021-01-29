//
//  SAPermissions.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/8/29.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "SAPermissions.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <Photos/PHPhotoLibrary.h>

@implementation SAPermissions

+ (void)userTrackingAuthorization:(void(^)(NSString *idfa))completion {

    __block NSString *idfa;
    if (@available(iOS 14, *)) {
        ATTrackingManagerAuthorizationStatus result = [ATTrackingManager trackingAuthorizationStatus];
        NSLog(@"---------- current status:%lu", (unsigned long)result);
//
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
                completion(idfa);
            }
            NSLog(@"---------- current status:%lu", (unsigned long)status);
        }];
    } else {
        // 使用原方式访问 IDFA
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            idfa = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
            completion(idfa);
        }
    }
}

+ (void)photoLibraryAuthorization:(void(^)(void))completion {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized: //已获取权限
                    break;

                case PHAuthorizationStatusDenied: //用户已经明确否认了这一照片数据的应用程序访问
                    break;

                case PHAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限
                    break;

                default://其他。。。
                    break;
            }
        });
    }];
}

@end
