//
//  LQVideoExplainCell.m
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoExplainCell.h"
#import "LQVideoExplainCellFrame.h"
#import "LQVideoModel.h"

@interface LQVideoExplainCell()

@property (nonatomic, weak) UILabel *titleLable;
@property (weak, nonatomic) UILabel *contentLable;

@end

@implementation LQVideoExplainCell

+ (LQVideoExplainCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    LQVideoExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQVideoExplainCell"];
    if (cell == nil)
    {
        cell = [[LQVideoExplainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LQVideoExplainCell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.frame = CGRectMake(15, 15, 60, 15);
        titleLable.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLable];
        self.titleLable = titleLable;
        
        UILabel *contentLable = [[UILabel alloc] init];
        contentLable.font = ContentLable_Font;
        contentLable.textColor = [UIColor lightGrayColor];
        contentLable.numberOfLines = 0;
        [self addSubview:contentLable];
        self.contentLable = contentLable;
        
    }
    return self;
}

- (void)setCellFrame:(LQVideoExplainCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    LQVideoModel *videoModel = cellFrame.videoModel;
    
    self.contentLable.frame = CGRectMake(15, CGRectGetMaxY(self.titleLable.frame)+10, LQScreen_Width-30, cellFrame.contentHeight);
    
    self.titleLable.text = videoModel.title;
    self.contentLable.text = videoModel.content;
}

@end
