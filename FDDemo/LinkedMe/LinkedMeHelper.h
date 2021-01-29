//
//  LinkedMeHelper.h
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkedMeHelper : NSObject

+ (instancetype)sharedInstance;

- (void)setupLinkedMe:(NSDictionary *)launchOptions;

- (BOOL)canOpenSchemeURL:(NSURL *)url;

- (BOOL)canOpenUniversalURL:(NSUserActivity *)userActivity;

@end

NS_ASSUME_NONNULL_END
