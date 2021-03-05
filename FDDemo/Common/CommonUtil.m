//
//  CommonUtil.m
//  FDDemo
//
//  Created by 彭远洋 on 2020/12/11.
//  Copyright © 2020 Sensors Data Inc. All rights reserved.
//

#import "CommonUtil.h"
#import <objc/runtime.h>

@implementation CommonUtil

+ (NSDictionary<NSString *, NSString *> *)queryItemsWithURL:(NSURL *)url {
    if (!url) {
        return nil;
    }
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    return [self queryItemsWithURLComponents:components];
}

+ (NSDictionary<NSString *, NSString *> *)queryItemsWithURLComponents:(NSURLComponents *)components {
    if (!components) {
        return nil;
    }
    NSMutableDictionary *items = [NSMutableDictionary dictionary];
    NSArray<NSString *> *queryArray = [components.percentEncodedQuery componentsSeparatedByString:@"&"];
    for (NSString *itemString in queryArray) {
        NSArray<NSString *> *itemArray = [itemString componentsSeparatedByString:@"="];
        if (itemArray.count >= 2) {
            items[itemArray.firstObject] = itemArray.lastObject;
        }
    }
    return items;
}

+ (void)LogCurrentClassMethods:(id)classObj {
    NSLog(@"CommonUtil: 当前类名 ==== %@", object_getClass(classObj));
    unsigned int count;
    Method *methods = class_copyMethodList(object_getClass(classObj), &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
//        if ([name hasPrefix:@"test"])
        NSLog(@"CommonUtil: 方法名 ==== %@",name);
        if (name) {
            //avoid arc warning by using c runtime
//            objc_msgSend(self, selector);
        }
//        NSLog(@"Test '%@' completed successfuly", name);
    }
}

+ (void)logClassPropertiesAndMethods:(Class)className {
//    NSLog(@"%@",[className _methodDescription]);
}

@end
