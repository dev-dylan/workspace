//
//  SFHelper.h
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFHelper : NSObject

#ifdef ENABLE_SENSORS_FOCUS

+ (void)setupSensorsFocus;

#endif

@end

NS_ASSUME_NONNULL_END
