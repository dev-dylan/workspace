//
//  ViewController.m
//  ListClickDemo
//
//  Created by 彭远洋 on 2020/11/4.
//

#import "ViewController.h"
#import "ScrollViewDelegate.h"

@interface SuperViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ScrollViewDelegate *delegate;

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];

//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    _delegate = [[ScrollViewDelegate alloc] init];
    _delegate.tableView = _tableView;
    _delegate.root = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@_%ld_%ld", NSStringFromClass(self.class), indexPath.section, indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Controller_子类点击");
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
