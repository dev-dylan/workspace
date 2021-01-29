//
//  ScrollViewDelegate.m
//  ListClickDemo
//
//  Created by 彭远洋 on 2020/11/4.
//

#import "ScrollViewDelegate.h"
#import "ViewController.h"
#import "NextViewController.h"
#import "ProductCateogoryViewController.h"

@interface ScrollCollectionViewCell : UICollectionViewCell

@end
@implementation ScrollCollectionViewCell

@end

@implementation ScrollViewDelegate

#pragma mark - table view
- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"ScrollViewDelegate_%ld_%ld", indexPath.section, indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITabBarController *tabBar = self.root.tabBarController;
//    [tabBar setSelectedIndex:1];
    ProductCateogoryViewController *categoryController = [[ProductCateogoryViewController alloc] init];
    [self.root.navigationController pushViewController:categoryController animated:YES];
}

#pragma mark - collecion view
- (void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.collectionView registerClass:[ScrollCollectionViewCell class] forCellWithReuseIdentifier:@"scrollIdentifier"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scrollIdentifier" forIndexPath:indexPath];

    for ( UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundColor:[UIColor whiteColor]];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button setTitle:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.item]] forState:UIControlStateNormal];
//    button.frame = CGRectMake(0, 0, 60, 60);

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 414, 60)];
    label.text = [NSString stringWithFormat:@"%@_%ld_%ld",NSStringFromClass(self.class), (long)indexPath.section, indexPath.row];
    label.textColor = [UIColor redColor];
    [cell.contentView addSubview:label];
//    [cell.contentView addSubview:button];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NextViewController *vc = [NextViewController new];
//    [self.root.navigationController pushViewController:vc animated:YES];
    UITabBarController *tabBar = self.root.tabBarController;
    [tabBar setSelectedIndex:0];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(414, 60);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
