//
//  LQInformationTableViewCell.h
//  美发沙龙网
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQNewsListContent.h"

#define cell_height 75

@interface LQInformationTableViewCell : UITableViewCell

@property (weak, nonatomic)  UIImageView *titleImageView;
@property (weak, nonatomic)  UILabel *titleLable;
@property (weak, nonatomic)  UILabel *dateLable;
@property (weak, nonatomic)  UILabel *numLable;
@property (nonatomic, strong) LQNewsListContent *listContent;

+ (LQInformationTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
