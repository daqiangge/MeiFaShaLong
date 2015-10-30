//
//  LQVideoExplainCell.h
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ContentLable_Font ([UIFont systemFontOfSize:14])

@class LQVideoModel;

@interface LQVideoExplainCell : UITableViewCell

@property (nonatomic, strong) LQVideoModel *videoModel;

+ (LQVideoExplainCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
