//
//  BaseAdapter.h
//  FDDemo
//
//  Created by 彭远洋 on 2019/12/9.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAdapter : NSObject <UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIViewController *caller;

- (instancetype)initWithTableView:(UITableView *)tableView;
- (void)customInit;

@end

NS_ASSUME_NONNULL_END
