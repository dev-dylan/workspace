//
//  CAIDHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2021/2/20.
//  Copyright © 2021 Sensors Data Inc. All rights reserved.
//

#import "CAIDHelper.h"
#import "CAID.h"

@implementation SACAIDInfo

- (NSString *)caidString {
    NSMutableString *result = [[NSMutableString alloc] init];
    if (![self.caid isEqualToString:@""] && self.version) {
        [result appendFormat:@"caid=%@&caid_version=%@", self.caid, self.version];
    }
    if (![self.lastVersionCAID isEqualToString:@""] && self.lastVersion) {
        NSString *connector = [result isEqualToString:@""] ? @"" : @"&";
        [result appendFormat:@"%@last_caid=%@&last_caid_version=%@", connector, self.lastVersionCAID, self.lastVersion];
    }
    return result;
}

@end

@implementation CAIDHelper

+ (void)getCAIDAsyncly:(void(^)(SACAIDInfo *info))callback {

    /*
     MIIBkDCB+gIJAMKBlRpWg1qsMA0GCSqGSIb3DQEBCwUAMA0xCzAJBgNVBAYTAkNO
     MB4XDTIxMDIwMjEyMjIxMloXDTIxMDMwNDEyMjIxMlowDTELMAkGA1UEBhMCQ04w
     gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALnhE3O8ZqxcsqxVNIUPfgjFzWeV
     5+IVdmq+ntGmriHQ7ybu0YdroCkwNwlVXgTB/9CEKN6Df9DJI8Asv7Q9JEUpSfc7
     9jSPW62REUTHcU1qVCUXo1ASMg1SuaZcpcTpqvsmWELORUnZL9HdzwyZ40J8YcP8
     Nlc1cwi+8y8Mr+SfAgMBAAEwDQYJKoZIhvcNAQELBQADgYEAH+cfytfeXOOCHnYh
     rFcxTykPLmOIpYr6IpK4Xjzggpo9qvVpj2HFJsPfBYtxt9tya/qQ8Us6uuMWRjyX
     Gfyxo8nqWTs2zTw10dOAE6ZwE7eXeb1aJ9JqJFZD1n447zcyCpBgY09TAC6WUcD4
     IDlM/PuPFS9sAJnIeXmsponB9vg=
     MIIBkDCB+gIJAMKBlRpWg1qsMA0GCSqGSIb3DQEBCwUAMA0xCzAJBgNVBAYTAkNO
     MB4XDTIxMDIwMjEyMjIxMloXDTIxMDMwNDEyMjIxMlowDTELMAkGA1UEBhMCQ04w
     gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALnhE3O8ZqxcsqxVNIUPfgjFzWeV
     5+IVdmq+ntGmriHQ7ybu0YdroCkwNwlVXgTB/9CEKN6Df9DJI8Asv7Q9JEUpSfc7
     9jSPW62REUTHcU1qVCUXo1ASMg1SuaZcpcTpqvsmWELORUnZL9HdzwyZ40J8YcP8
     Nlc1cwi+8y8Mr+SfAgMBAAEwDQYJKoZIhvcNAQELBQADgYEAH+cfytfeXOOCHnYh
     rFcxTykPLmOIpYr6IpK4Xjzggpo9qvVpj2HFJsPfBYtxt9tya/qQ8Us6uuMWRjyX
     Gfyxo8nqWTs2zTw10dOAE6ZwE7eXeb1aJ9JqJFZD1n447zcyCpBgY09TAC6WUcD4
     IDlM/PuPFS9sAJnIeXmsponB9vg=
     */
    NSString *pubKey = @"MIIBkDCB+gIJAMKBlRpWg1qsMA0GCSqGSIb3DQEBCwUAMA0xCzAJBgNVBAYTAkNOMB4XDTIxMDIwMjEyMjIxMloXDTIxMDMwNDEyMjIxMlowDTELMAkGA1UEBhMCQ04wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALnhE3O8ZqxcsqxVNIUPfgjFzWeV5+IVdmq+ntGmriHQ7ybu0YdroCkwNwlVXgTB/9CEKN6Df9DJI8Asv7Q9JEUpSfc79jSPW62REUTHcU1qVCUXo1ASMg1SuaZcpcTpqvsmWELORUnZL9HdzwyZ40J8YcP8Nlc1cwi+8y8Mr+SfAgMBAAEwDQYJKoZIhvcNAQELBQADgYEAH+cfytfeXOOCHnYhrFcxTykPLmOIpYr6IpK4Xjzggpo9qvVpj2HFJsPfBYtxt9tya/qQ8Us6uuMWRjyXGfyxo8nqWTs2zTw10dOAE6ZwE7eXeb1aJ9JqJFZD1n447zcyCpBgY09TAC6WUcD4IDlM/PuPFS9sAJnIeXmsponB9vg=";
    NSDictionary *caid = [[NSUserDefaults standardUserDefaults] objectForKey:@"SACAIDInfo"];
    if (caid) {
        SACAIDInfo *caidInfo = [[SACAIDInfo alloc] init];
        caidInfo.caid = caid[@"caid"];
        caidInfo.version = caid[@"version"];
        caidInfo.lastVersionCAID = caid[@"lastCaid"];
        caidInfo.lastVersion = caid[@"lastCaidVersion"];
        callback(caidInfo);
    } else {
        static dispatch_once_t onceToken;
        static CAID *obj;
        dispatch_once(&onceToken, ^{
            obj = [CAID initCAID:@"10231" pubKey:pubKey];
        });
        [obj getCAIDAsyncly:^(CAIDError * _Nonnull error, CAIDStruct * _Nonnull caidStruct) {
            if (error.code == 0) {
                SACAIDInfo *caidInfo = [[SACAIDInfo alloc] init];
                caidInfo.caid = caidStruct.caid;
                caidInfo.version = caidStruct.version;
                caidInfo.lastVersionCAID = caidStruct.lastVersionCAID;
                caidInfo.lastVersion = caidStruct.lastVersion;
                NSDictionary *props = @{@"caid":caidStruct.caid, @"version":caidStruct.version, @"lastCaid":caidStruct.lastVersionCAID, @"lastCaidVersion":caidStruct.lastVersion};
                [[NSUserDefaults standardUserDefaults] setObject:props forKey:@"SACAIDInfo"];
                callback(caidInfo);
            }
        }];
    }
}

@end
