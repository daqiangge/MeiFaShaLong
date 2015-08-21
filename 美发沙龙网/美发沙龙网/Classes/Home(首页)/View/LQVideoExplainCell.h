//
//  LQVideoExplainCell.h
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQVideoExplainCellFrame;

@interface LQVideoExplainCell : UITableViewCell

@property (nonatomic, strong) LQVideoExplainCellFrame *cellFrame;

+ (LQVideoExplainCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
