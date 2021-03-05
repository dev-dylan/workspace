//
//  BUADHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2021/2/25.
//  Copyright © 2021 Sensors Data Inc. All rights reserved.
//

#import "BUADHelper.h"

#if __has_include(<BUAdSDK/BUAdSDK.h>)
#import <BUAdSDK/BUAdSDK.h>

@interface BUADHelper () <BUNativeAdsManagerDelegate, BUNativeExpressAdViewDelegate>

@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) BUNativeExpressAdManager *nativeExpressAdManager;
@property (nonatomic, copy) BUADGetExpressAdCallback callback;
@property (nonatomic, strong) NSArray<UIView *> *views;

@end

@implementation BUADHelper

+ (instancetype)helper {
    static dispatch_once_t onceToken;
    static BUADHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[BUADHelper alloc] init];
    });
    return helper;
}

+(void)setup {
    [BUAdSDKManager setAppID:@"5146692"];
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
    /// Coppa 0 adult, 1 child
    [BUAdSDKManager setCoppa:0];
    [[BUADHelper helper] loadAd];
}

+ (void)asyncGetExpressAd:(BUADGetExpressAdCallback)callback {
    if ([BUADHelper helper].views) {
        callback([BUADHelper helper].views);
        return;
    }
    [BUADHelper helper].callback = callback;
}

- (void)loadAd {
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = @"945869653";
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    slot1.position = BUAdSlotPositionFeed;
    // self.nativeExpressAdManager可以重用
     if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(SCREEN_WIDTH, 44)];
        }
    self.nativeExpressAdManager.adSize = CGSizeMake(SCREEN_WIDTH, 44);
    self.nativeExpressAdManager.delegate = self;
    [self.nativeExpressAdManager loadAdDataWithCount:3];

}

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    NSLog(@"======== %@", nativeAdDataArray);
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {

}

/**
 * Sent when views successfully load ad
 */
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    self.views = views;
    for (BUNativeExpressAdView *view in views) {
        NSLog(@"======== %@", view);
    }
    if (self.callback) {
        self.callback(views);
    }
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *_Nullable)error {
    NSLog(@"======== %@", error.localizedDescription);
}

@end

@implementation UIView (BUADHelper)

- (void)setRootViewController:(UIViewController *)controller {

}

- (void)render {

}

@end

#else

@implementation BUADHelper

+ (void)setup{}
+ (void)asyncGetExpressAd:(BUADGetExpressAdCallback)callback{}

@end

@implementation UIView (BUADHelper)

- (void)setRootViewController:(UIViewController *)controller {}
- (void)render {}

@end

#endif

