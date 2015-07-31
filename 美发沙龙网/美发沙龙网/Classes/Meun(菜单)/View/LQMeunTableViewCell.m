//
//  LQMeunTableViewCell.m
//  美发沙龙网
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQMeunTableViewCell.h"

@implementation LQMeunTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.frame = CGRectMake(35, 0, self.width - 35, self.height);
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textColor = [UIColor whiteColor];
    [self addSubview:titleLable];
    self.titleLable = titleLable;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
    lineView.backgroundColor = [UIColor colorWithRed:39/255. green:39/255. blue:39/255. alpha:1];
    [self addSubview:lineView];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
