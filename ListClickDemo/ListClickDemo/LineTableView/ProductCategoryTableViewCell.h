//
//  ProductCategoryTableViewCell.h
//  LinkTableViewDemo
//
//  Created by 赵富星 on 16/9/12.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *productView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
