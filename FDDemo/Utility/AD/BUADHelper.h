//
//  BUADHelper.h
//  FDDemo
//
//  Created by 彭远洋 on 2021/2/25.
//  Copyright © 2021 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BUADGetExpressAdCallback)(NSArray<UIView *> *);

@interface BUADHelper : NSObject

+ (void)setup;
+ (void)asyncGetExpressAd:(BUADGetExpressAdCallback)callback;

@end

@interface UIView (BUADHelper)

- (void)setRootViewController:(UIViewController *)controller;
- (void)render;

@end

NS_ASSUME_NONNULL_END
