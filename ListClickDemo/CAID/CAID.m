//
// CAID.m
// SensorsAnalyticsSDK
//
// Created by 彭远洋 on 2021/3/4.
// Copyright © 2021 Sensors Data Co., Ltd. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag on this file.
#endif

#import "CAID.h"

@implementation CAID

// 初始化，传入APPID和公钥
+(instancetype) initCAID:(NSString *)devId pubKey:(NSString *)pubKey {
    return [[CAID alloc] init];
}

/*
 * 异步方式请求服务端获取CAID数据，当前线程结束。
 * callback返回结果中回传错误信息和CAID数据
 * CAID数据中包含
 *  1. 当前版本CAID
 *  2. 当前CAID版本号
 *  3. 上一个版本CAID
 *  4. 上一个版本CAID对应版本号
 */
-(void)getCAIDAsyncly:(CAIDCallback)callback {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAIDStruct *caid = [[CAIDStruct alloc] init];
        caid.version = @(20200809);
        caid.caid = @"BFB405DC6C3B16E8B1BA40BCD3A72222";
        caid.lastVersion = @(20201201);
        caid.lastVersionCAID = @"BFB405DC6C3B16E8B1BA40BCD3A71111";
        CAIDError *error = [CAIDError errorWithCode:CAIDErrorCodeNone message:@"测试字段"];
        callback(error, caid);
    });
}

@end
