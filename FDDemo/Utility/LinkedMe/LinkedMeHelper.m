//
//  LinkedMeHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "LinkedMeHelper.h"

#if __has_include(<LinkedME_iOS/LinkedME.h>)
#import <LinkedME_iOS/LinkedME.h>
#import <LinkedME_iOS/LMUniversalObject.h>
#import <LinkedME_iOS/LMLinkProperties.h>

@interface LinkedMeHelper ()

@property (nonatomic, strong) LMUniversalObject *linkedUniversalObject;

@end

@implementation LinkedMeHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static LinkedMeHelper *helper;
    dispatch_once(&onceToken, ^{
        helper = [[LinkedMeHelper alloc] init];
    });
    return helper;
}

- (void)setupLinkedMe:(NSDictionary *)launchOptions {
    enable = YES;
    //初始化及实例
    LinkedME* linkedme = [LinkedME getInstance];
    [linkedme initSessionWithLaunchOptions:launchOptions andRegisterDeepLinkHandler:^(NSDictionary *params, NSError *error) {
        if (!error) {
            //防止传递参数出错取不到数据,导致App崩溃这里一定要用try catch
            @try {
                NSLog(@"LinkedME finished init with params = %@",[params description]);
                //获取标题
                NSString *title = [params objectForKey:@"$og_title"];
                NSString *tag = params[@"$control"][@"View"];
                NSLog(@"LinkedME title: %@, tag: %@", title, tag);
            } @catch (NSException *exception) {
            } @finally {
            }
        } else {
            NSLog(@"LinkedME failed init: %@", error);
        }
    }];
    [self addPara];
}

-(void)addPara{
    self.linkedUniversalObject = [[LMUniversalObject alloc] initWithCanonicalIdentifier:@"item/12345"];
    self.linkedUniversalObject.title = @"titl1212e";
    self.linkedUniversalObject.contentDescription = @"My Content 12312312Description";
    self.linkedUniversalObject.imageUrl = @"https://s3-us-west-1.amazonaws.com/branchhost/mosaic_og.png";
    [self.linkedUniversalObject addMetadataKey:@"custom_key1" value:@"some custom data"];
    [self.linkedUniversalObject addMetadataKey:@"custom_key2" value:@"more custom data"];

    LMLinkProperties *linkProperties = [[LMLinkProperties alloc] init];
    linkProperties.channel = @"baid21312u";
    linkProperties.tags=@[@"lab21312el"];
    linkProperties.stage = @"al12312ive";

    linkProperties.source = @"iOS11123";

    [linkProperties setAndroidPathControlParam:@"*"];
    [linkProperties setIOSKeyControlParam:@"*"];

    [self.linkedUniversalObject getShortUrlWithLinkProperties:linkProperties andCallback:^(NSString *url, NSError *err) {
        if (url) {
            NSLog(@"[LinkedME Info] SDK creates the url is:%@", url);
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = url;
        }
    }];
}

- (BOOL)canOpenSchemeURL:(NSURL *)url {
    if (!enable) {
        return NO;
    }
    //判断是否是通过LinkedME的UrlScheme唤起App
    if ([[url description] rangeOfString:@"click_id"].location != NSNotFound) {
        return [[LinkedME getInstance] handleDeepLink:url];
    }
    return NO;
}

- (BOOL)canOpenUniversalURL:(NSUserActivity *)userActivity {
    if (!enable) {
        return NO;
    }
    if ([[userActivity.webpageURL description] rangeOfString:@"lkme.cc"].location != NSNotFound) {
        return  [[LinkedME getInstance] continueUserActivity:userActivity];
    }
    return NO;
}

@end

#else

@interface LinkedMeHelper ()

@end

@implementation LinkedMeHelper

+ (instancetype)sharedInstance {return nil;}
- (void)setupLinkedMe:(NSDictionary *)launchOptions {}
- (BOOL)canOpenSchemeURL:(NSURL *)url {return NO;}
- (BOOL)canOpenUniversalURL:(NSUserActivity *)userActivity{return NO;}

@end

#endif
