//
//  ScrollViewDelegate.h
//  ListClickDemo
//
//  Created by 彭远洋 on 2020/11/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIViewController *root;
@end

NS_ASSUME_NONNULL_END
