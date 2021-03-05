//
//  CommonUtil.h
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtil : NSObject

+ (NSDictionary<NSString *, NSString *> *)queryItemsWithURL:(NSURL *)url;
+ (NSDictionary<NSString *, NSString *> *)queryItemsWithURLComponents:(NSURLComponents *)components;
+ (void)LogCurrentClassMethods:(id)classObj;

@end

NS_ASSUME_NONNULL_END
