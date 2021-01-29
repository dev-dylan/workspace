//
//  FirstAdapter.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/12/9.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "FirstAdapter.h"

@interface FirstAdapter () <UITableViewDelegate>

@end

@implementation FirstAdapter

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" ======= FirstAdapter 事件点击");
/*
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"合规" message:@"请允许合规！" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"同意！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"action ========== %@", @(UIApplication.sharedApplication.backgroundTimeRemaining));
    }]];
    [self.caller presentViewController:controller animated:YES completion:nil];
*/
}

@end
