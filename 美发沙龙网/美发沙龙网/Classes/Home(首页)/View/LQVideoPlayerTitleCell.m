//
//  LQVideoPlayerTitleCell.m
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoPlayerTitleCell.h"

@interface LQVideoPlayerTitleCell()
@property (weak, nonatomic) IBOutlet UIButton *fenxiangBtn;
@property (weak, nonatomic) IBOutlet UIButton *chongzhiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shouchangBtn;
@property (weak, nonatomic) IBOutlet UIButton *dianshuBtn;

@end


@implementation LQVideoPlayerTitleCell

+ (LQVideoPlayerTitleCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *idenifier = @"LQVideoPlayerTitleCell";
    UINib *nib = [UINib nibWithNibName:idenifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:idenifier];
    
    LQVideoPlayerTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class])isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches =NO;
            break;
        }
    }
    
    return cell;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self setBtnLayer:self.fenxiangBtn];
    [self setBtnLayer:self.chongzhiBtn];
    [self setBtnLayer:self.shouchangBtn];
    [self setBtnLayer:self.dianshuBtn];
}

- (void)setBtnLayer:(UIButton *)btn
{
    btn.layer.borderColor = Layer_BorderColor;
    btn.layer.borderWidth = Layer_BorderWidth;
}

- (IBAction)fenxiang:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(fenxiangBtnDidClickWithCell:)])
    {
        [self.delegate fenxiangBtnDidClickWithCell:self];
    }
}

@end
