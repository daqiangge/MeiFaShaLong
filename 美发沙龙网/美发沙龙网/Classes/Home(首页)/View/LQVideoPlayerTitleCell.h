//
//  LQVideoPlayerTitleCell.h
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQVideoPlayerTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *VideoTitleLable;

+ (LQVideoPlayerTitleCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
