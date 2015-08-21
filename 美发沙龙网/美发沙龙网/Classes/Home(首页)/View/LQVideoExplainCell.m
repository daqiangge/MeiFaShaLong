//
//  LQVideoExplainCell.m
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoExplainCell.h"
#import "LQVideoExplainCellFrame.h"

@interface LQVideoExplainCell()

@property (nonatomic, weak) UILabel *titleLable;
@property (weak, nonatomic) UILabel *contentLable;

@end

@implementation LQVideoExplainCell

+ (LQVideoExplainCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *idenifier = @"LQVideoExplainCell";
    UINib *nib = [UINib nibWithNibName:idenifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:idenifier];
    
    LQVideoExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQVideoExplainCell"];
    cell.backgroundColor = RGB(246, 246, 246);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentLable.text = @"我湿\n答答\n啊地\n\n方各位\n 啊的身\n份嘎\n\n的水电费人工费";
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(15, 15, 60, 15);
        lable.font = [UIFont systemFontOfSize:15];
        [self addSubview:lable];
        
        
    }
    return self;
}

- (void)setCellFrame:(LQVideoExplainCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
}

@end
