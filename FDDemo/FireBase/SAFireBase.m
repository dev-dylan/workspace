//
//  SAFireBase.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/5/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "SAFireBase.h"
//#import <Firebase/Firebase.h>
//#import <FirebaseAnalytics/FirebaseAnalytics.h>

@implementation SAFireBase

+ (void)configure {
//    [FIRApp configure];
//
//    [SAFireBase logEventWithName:@"AppStart" parameters:@{
//    kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"AppStart"],
//    kFIRParameterItemName:@"AppStart",
//    kFIRParameterContentType:@"AppStart"
//    }];
//
//    [SAFireBase logEventWithName:@"LogEvent" parameters:@{
//    kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", @"LogEvent"],
//    kFIRParameterItemName:@"LogEvent",
//    kFIRParameterContentType:@"LogEvent"
//    }];
}

+ (void)logEventWithName:(NSString *)name parameters:(NSDictionary *)parameters {
//    [FIRAnalytics logEventWithName:name parameters:parameters];
}

@end
