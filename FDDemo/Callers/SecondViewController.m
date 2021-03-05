//
//  SecondViewController.m
//  FDDemo
//
//  Created by 彭远洋 on 2019/6/17.
//  Copyright © 2019 Sensors Data Inc. All rights reserved.
//

#import "SecondViewController.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "SAHelper.h"
#import "FDUniAppHelper.h"
#import "FirstViewController.h"

@interface SecondViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISwitch *switchs;
@property (assign, nonatomic) NSInteger count;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"测试";

//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"测试测试" style:UIBarButtonItemStyleDone target:self action:@selector(itemClick)];
//    self.navigationItem.rightBarButtonItem = item;
    _count = 1;
    [self elementText];
}

- (void)elementText {
    [_button setTitle:@"激活事件" forState:UIControlStateNormal];
}

#pragma mark - element click
- (void)itemClick {
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)sliderAction:(id)sender {
    NSLog(@"sliderAction");
}

- (IBAction)switchAction:(id)sender {
    [SAHelper track:@"testEvent" properties:@{@"testKey":@"testValue"}];
}

- (IBAction)buttonAction:(id)sender {
    FirstViewController *vc = [FirstViewController new];
    [self.navigationController pushViewController:vc animated:YES];

    // 初始化小程序的配置信息对象
//    [FDUniAppHelper openUniMP];
}

#pragma mark - Picker & DatePicker
- (void)initPicker {
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 400, 300, 300)];
    // 添加 Target-Action
    [datePicker addTarget:self
                   action:@selector(datePickerValueChanged:)
         forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:datePicker];

    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(100, 400, 300, 300)];
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view API_UNAVAILABLE(tvos) {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"测试内容";
    return  label;
}

- (void)datePickerValueChanged:(id)sender {
    NSLog(@"========= datePickerValueChanged");
}

#pragma mark - tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"======= SecondViewController 子类点击");
}

@end
