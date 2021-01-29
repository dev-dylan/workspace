//
//  SFHelper.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "SFHelper.h"

#ifdef ENABLE_SENSORS_FOCUS
#import <SensorsFocus/SensorsFocus.h>
#endif

@interface SFHelper ()

@end

@implementation SFHelper

#ifdef ENABLE_SENSORS_FOCUS
+ (void)setupSensorsFocus {
    SFConfigOptions *sfOptions = [[SFConfigOptions alloc] initWithApiBaseURL:@"http://10.42.189.228:8141"];
    sfOptions.popupDelegate = self;
    [SensorsFocus startWithConfigOptions:sfOptions];
}

#pragma mark - sensors focus
- (void)popupLoadSuccessWithPlanID:(NSString *)planID {
    NSLog(@"Popup window load success, planID: %@", planID);
}

- (void)popupLoadFailedWithPlanID:(NSString *)planID error:(NSError *)error {
    NSLog(@"Popup window load failed, planID: %@, error: %@", planID, error);
}

- (void)popupDidClickWithPlanID:(NSString *)planID action:(SensorsFocusActionModel *)action {
    NSLog(@"Did click action: %@,\n Plan id: %@", action, planID);
    switch (action.type) {
        case SensorsFocusActionTypeClose:
            // close popup window
            break;
        case SensorsFocusActionTypeOpenlink:
            // open a link, the value is a string
            NSLog(@"%@", action.value);
            break;
        case SensorsFocusActionTypeCopy:
            // copy the value to Pasteboard
            NSLog(@"%@", action.value);
            break;
        case SensorsFocusActionTypeCustomize:
            // customize
            NSLog(@"%@", action.extra);
            break;
        default:
            break;
    }
}

- (void)popupDidCloseWithPlanID:(NSString *)planID {
    NSLog(@"Popup window did close, planID: %@", planID);
}

#endif
@end
