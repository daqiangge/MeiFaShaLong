//
//  LQCommodityCommentCell.h
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQCommodityCommentCellFrame.h"

@interface LQCommodityCommentCell : UITableViewCell

@property (nonatomic, strong) LQCommodityCommentCellFrame *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
