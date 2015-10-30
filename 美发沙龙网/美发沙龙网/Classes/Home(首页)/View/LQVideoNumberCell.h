//
//  LQVideoNumberCell.h
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQVideoNumberCell;

@protocol LQVideoNumberCellDelegate <NSObject>

- (void)videoNumberCellDidClickBtnWithView:(LQVideoNumberCell *)view btn:(UIButton *)btn;

@end


@interface LQVideoNumberCell : UITableViewCell

@property (nonatomic, weak) id<LQVideoNumberCellDelegate> delegate;

//视频集数
@property (nonatomic, assign) int totalpath;

+ (LQVideoNumberCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
- (IBAction)buttonDidClick:(UIButton *)sender;

@end
