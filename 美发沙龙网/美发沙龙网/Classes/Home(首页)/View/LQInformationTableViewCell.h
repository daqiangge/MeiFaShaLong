//
//  LQInformationTableViewCell.h
//  美发沙龙网
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQInformationTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *numLable;

@end
