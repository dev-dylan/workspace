//
//  CAID.h
//  CAIDSample
//
//  Created by CDA on 2020/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAID : NSObject

// 初始化，传入APPID和公钥，获得实例
+(instancetype) initCAID:(NSString *)devId pubKey:(NSString *)pubKey;

// 获取CAID，如果内存中已经存在，直接返回。若不存在异步请求服务端获取,当前返回nil
-(NSString *) CAID;

// 获取上个版本CAID,如果暂没有，则返回空
-(NSString *) lastVersionCAID;

@end

NS_ASSUME_NONNULL_END
