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
    
    self.oneBtn.selected = YES;
    self.btn = self.oneBtn;
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


@end
