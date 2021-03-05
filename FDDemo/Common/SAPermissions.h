//
//  SAPermissions.h
//  FDDemo
//
//  Created by 彭远洋 on 2020/8/29.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAPermissions : NSObject

+ (void)userTrackingAuthorization:(void(^)(NSString *idfa))completion;
+ (void)photoLibraryAuthorization:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
