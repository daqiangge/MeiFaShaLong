//
//  LQCommodityIntroductionCell.h
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQCommodityIntroductionCellFrame.h"


@interface LQCommodityIntroductionCell : UITableViewCell

@property (nonatomic, strong) LQCommodityIntroductionCellFrame *cellFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
