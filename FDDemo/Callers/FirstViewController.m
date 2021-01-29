//
//  FirstViewController.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/11/20.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstAdapter.h"
#import "SAHelper.h"

@interface FirstViewController ()

@property (nonatomic, strong) FirstAdapter *adapter;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 50, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"first 测试" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)buttonClick {

    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
