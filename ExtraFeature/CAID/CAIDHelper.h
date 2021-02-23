//
//  CAIDHelper.h
//  FDDemo
//
//  Created by 彭远洋 on 2021/2/20.
//  Copyright © 2021 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAID.h"

NS_ASSUME_NONNULL_BEGIN

@interface SACAIDInfo : NSObject

@property (nonatomic, copy) NSString *caid;
@property (nonatomic, copy) NSNumber *version;
@property (nonatomic, copy) NSString *lastVersionCAID;
@property (nonatomic, copy) NSNumber *lastVersion;

- (NSString *)caidString;

@end

@interface CAIDHelper : NSObject

+ (void)getCAIDAsyncly:(void(^)(SACAIDInfo *info))callback;

@end

NS_ASSUME_NONNULL_END
