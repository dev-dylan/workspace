//
//  FirstViewController.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/11/20.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "FirstViewController.h"
#import "SAHelper.h"
#import "BUADHelper.h"

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<UIView *> *items;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"first 测试" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick)];
    self.navigationItem.rightBarButtonItem = item;

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];

    [BUADHelper asyncGetExpressAd:^(NSArray<UIView *> * _Nonnull views) {
        for (UIView *view in views) {
            [view setRootViewController:self];
//            [self.view addSubview:view];
//            [self.view bringSubviewToFront:view];
            NSLog(@"========%@", view);
        }
        self.items = views;
    }];
}

- (void)buttonClick {
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [@(indexPath.row) stringValue];
    if (self.items.count > indexPath.row) {
        UIView *view = self.items[indexPath.row];
        [view render];
        [cell.contentView addSubview:view];
    }
    return cell;
}

@end
