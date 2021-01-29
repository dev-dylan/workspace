//
//  SecondAdapter.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/12/9.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "SecondAdapter.h"

@interface SecondAdapter () <UITableViewDelegate>

@end

@implementation SecondAdapter

- (void)customInit {
    self.tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" ======= SecondAdapter 事件点击");
    [super tableView:tableView didSelectRowAtIndexPath: indexPath];
}

@end
