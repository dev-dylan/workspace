//
//  BaseAdapter.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/12/9.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "BaseAdapter.h"

@interface BaseAdapter ()

@end

@implementation BaseAdapter

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self customInit];
    }
    return self;
}

- (void)customInit {
    self.tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" ======= BaseAdapter 事件点击");
}

@end
