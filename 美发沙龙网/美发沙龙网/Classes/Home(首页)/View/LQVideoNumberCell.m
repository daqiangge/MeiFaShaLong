//
//  LQVideoNumberCell.m
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoNumberCell.h"

@interface LQVideoNumberCell()

@property (weak, nonatomic) IBOutlet UILabel *sumLable;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBrn;
@property (weak, nonatomic) IBOutlet UIButton *fourBrn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBrn;
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (nonatomic, strong) UIButton *btn;

@end


@implementation LQVideoNumberCell

+ (LQVideoNumberCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *idenifier = @"LQVideoNumberCell";
    UINib *nib = [UINib nibWithNibName:idenifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:idenifier];
    
    LQVideoNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
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
    
    //默认第一个按钮选中
//    self.oneBtn.selected = YES;
//    self.btn = self.oneBtn;
}

- (IBAction)buttonDidClick:(UIButton *)sender
{
    self.btn.selected = NO;
    
    sender.selected = YES;
    self.btn = sender;
    
    if ([self.delegate respondsToSelector:@selector(videoNumberCellDidClickBtnWithView:btn:)])
    {
        [self.delegate videoNumberCellDidClickBtnWithView:self btn:sender];
    }
}

- (void)setTotalpath:(int)totalpath
{
    _totalpath = totalpath;
    
    self.sumLable.text = [NSString stringWithFormat:@"共%d集",self.totalpath];
    
    switch (totalpath) {
        case 0:
            break;
            
        case 1:
        {
            self.oneBtn.hidden = NO;
        }
            break;
            
        case 2:
        {
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = NO;
        }
            break;
            
        case 3:
        {
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = NO;
            self.threeBrn.hidden = NO;
        }
            break;
            
        case 4:
        {
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = NO;
            self.threeBrn.hidden = NO;
            self.fourBrn.hidden = NO;
        }
            break;
            
        case 5:
        {
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = NO;
            self.threeBrn.hidden = NO;
            self.fourBrn.hidden = NO;
            self.fiveBrn.hidden = NO;
        }
            break;
            
        default:
        {
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = NO;
            self.threeBrn.hidden = NO;
            self.fourBrn.hidden = NO;
            self.fiveBrn.hidden = NO;
            self.sixBtn.hidden = NO;
        }
            break;
    }
}


@end
