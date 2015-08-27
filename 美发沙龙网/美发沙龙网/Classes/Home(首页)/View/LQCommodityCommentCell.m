//
//  LQCommodityCommentCell.m
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQCommodityCommentCell.h"

@interface LQCommodityCommentCell()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *nameLable;
@property (nonatomic, weak) UILabel *contentLable;
@property (nonatomic, weak) UILabel *moreLable;

@end

@implementation LQCommodityCommentCell

- (UILabel *)titleLable
{
    if (!_titleLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(10, 10, LQScreen_Width - 20, 20);
        lable.textColor = [UIColor blackColor];
        lable.font = [UIFont systemFontOfSize:15];
        lable.text = @"商品评论";
        [self addSubview:lable];
        
        _titleLable = lable;
    }
    
    return _titleLable;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(self.titleLable.x, CGRectGetMaxY(self.titleLable.frame) + 5, 14, 14);
        [self addSubview:imageView];
        
        _iconImageView = imageView;
    }
    
    return _iconImageView;
}

- (UILabel *)nameLable
{
    if (!_nameLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5 , self.iconImageView.y, 150, self.iconImageView.height);
        lable.textColor = [UIColor blackColor];
        lable.font = [UIFont systemFontOfSize:self.iconImageView.height];
        [self addSubview:lable];
        
        _nameLable = lable;
    }
    
    return _nameLable;
}

- (UILabel *)contentLable
{
    if (!_contentLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(self.iconImageView.x, CGRectGetMaxY(self.iconImageView.frame) + 10, LQScreen_Width - 20, 30);
        lable.numberOfLines = 0;
        lable.textColor = [UIColor grayColor];
        lable.font = [UIFont systemFontOfSize:13];
        [self addSubview:lable];
        
        _contentLable = lable;
    }
    
    return _contentLable;
}

- (UILabel *)moreLable
{
    if (!_moreLable)
    {
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(10, CGRectGetMaxY(self.contentLable.frame) + 5, self.contentLable.width, 1);
        line.backgroundColor = RGB(234, 234, 234);
        [self addSubview:line];
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(0, CGRectGetMaxY(line.frame), LQScreen_Width, 30);
        lable.textColor = [UIColor grayColor];
        lable.font = [UIFont systemFontOfSize:15];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = @"查看更多评论";
        [self addSubview:lable];
        
        _moreLable = lable;
    }
    
    return _moreLable;
}

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
    LQCommodityCommentCell *cell = [[LQCommodityCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)doLoading
{
    
}

- (void)setCellFrame:(LQCommodityCommentCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    LQCommodityComment *commodityComment = cellFrame.commodityComment;
    
    self.contentLable.height = cellFrame.contentLableHeight;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:commodityComment.iconUrl] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    self.nameLable.text = commodityComment.name;
    self.contentLable.text = commodityComment.content;
    
    self.moreLable.hidden = NO;
}

@end
