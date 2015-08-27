//
//  LQCommodityIntroductionCell.m
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQCommodityIntroductionCell.h"
#import "LQCommodity.h"

@interface LQCommodityIntroductionCell()

@property (nonatomic, weak) UILabel *contentLable;

@end

@implementation LQCommodityIntroductionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self doLoading];
    }
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    LQCommodityIntroductionCell *cell = [[LQCommodityIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)doLoading
{
    UILabel *titleLable        = [[UILabel alloc] init];
    titleLable.frame           = CGRectMake(10, 10, LQScreen_Width - 20, 20);
    titleLable.font            = [UIFont systemFontOfSize:15];
    titleLable.textColor       = [UIColor blackColor];
    titleLable.text            = @"商品介绍";
    [self addSubview:titleLable];

    UILabel *contentLable      = [[UILabel alloc] init];
    contentLable.frame         = CGRectMake(titleLable.x, CGRectGetMaxY(titleLable.frame)+5, titleLable.width, 100);
    contentLable.font          = [UIFont systemFontOfSize:13];
    contentLable.textColor     = [UIColor grayColor];
    contentLable.numberOfLines = 0;
    [self addSubview:contentLable];
    self.contentLable          = contentLable;
}

- (void)setCellFrame:(LQCommodityIntroductionCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    LQCommodity *commodity = cellFrame.commodity;
    
    self.contentLable.height = cellFrame.contentLableHeight;
    
    self.contentLable.text = commodity.introduction;
}

@end
