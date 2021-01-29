//
//  ProductCateogoryViewController.m
//  LinkTableViewDemo
//
//  Created by 赵富星 on 16/9/12.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "ProductCateogoryViewController.h"
#import "ProductCategoryTableViewCell.h"
#import "ProductShopCollectionViewCell.h"
#import "BannerCollectionReusableView.h"

@interface ProductCateogoryViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *rightCollectionView;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation ProductCateogoryViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupView {
    self.navigationController.navigationBar.translucent = NO;
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)registerCell {
    UINib *categoryNib = [UINib nibWithNibName:NSStringFromClass([ProductCategoryTableViewCell class]) bundle:nil];
    [self.leftTableView registerNib:categoryNib forCellReuseIdentifier:NSStringFromClass([ProductCategoryTableViewCell class])];
    
    UINib *productShowNib =
    [UINib nibWithNibName:NSStringFromClass([ProductShopCollectionViewCell class])
                   bundle:nil];
    [self.rightCollectionView registerNib:productShowNib
          forCellWithReuseIdentifier:NSStringFromClass([ProductShopCollectionViewCell class])];
    
    UINib *bannerNib = [UINib nibWithNibName:NSStringFromClass([BannerCollectionReusableView class]) bundle:nil];
    [self.rightCollectionView registerNib:bannerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BannerCollectionReusableView class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductShopCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProductShopCollectionViewCell class])
                                              forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(floorf(CGRectGetWidth(self.rightCollectionView.frame) / 3) - 1, 130.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 1, 0, 1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section  {
    return CGSizeMake(self.rightCollectionView.frame.size.width, 125.0f);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BannerCollectionReusableView *reusableView =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                       withReuseIdentifier:NSStringFromClass([BannerCollectionReusableView class])
                                              forIndexPath:indexPath];
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"asdfadsfasdf");
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    [self.leftTableView reloadData];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductCategoryTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductCategoryTableViewCell class])];
    if (tableView == self.leftTableView) {
        cell.lineView.hidden = ![self.selectedIndexPath isEqual:indexPath];
        cell.productView.backgroundColor =
        [self.selectedIndexPath isEqual:indexPath] ? [UIColor whiteColor] : [UIColor clearColor];
        
    }
    return cell;
}

@end
