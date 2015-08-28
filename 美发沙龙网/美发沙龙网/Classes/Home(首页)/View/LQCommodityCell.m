//
//  LQCommodityCell.m
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQCommodityCell.h"

@interface LQCommodityCell()

@property (nonatomic, weak) UIImageView *commodityImageView;
@property (nonatomic, weak) UILabel *commodityNameLable;
@property (nonatomic, weak) UILabel *commodityPriceLable;
@property (nonatomic, weak) UILabel *commodityDiscountPriceLable;
@property (nonatomic, weak) UILabel *commodityNumberLable;//编号
@property (nonatomic, weak) UILabel *commodityBrandLable;
@property (nonatomic, weak) UILabel *commodityUnitLable;
@property (nonatomic, weak) UILabel *commodityAmountLable;//数量

@end

@implementation LQCommodityCell

- (UIImageView *)commodityImageView
{
    if (!_commodityImageView)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, LQScreen_Width, (LQScreen_Width *2)/3);
        imageView.image = [UIImage imageNamed:@"placehodeImage"];
        [self addSubview:imageView];
        
        _commodityImageView = imageView;
    }
    
    return _commodityImageView;
}

- (UILabel *)commodityNameLable
{
    if (!_commodityNameLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(10, CGRectGetMaxY(self.commodityImageView.frame)+5, LQScreen_Width-20, 36);
        lable.numberOfLines = 2;
        lable.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:lable];
        
        _commodityNameLable = lable;
    }
    
    return _commodityNameLable;
}

- (UILabel *)commodityDiscountPriceLable
{
    if (!_commodityDiscountPriceLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(self.commodityNameLable.x, CGRectGetMaxY(self.commodityNameLable.frame), self.commodityNameLable.width, 20);
        lable.numberOfLines = 1;
        lable.textColor = [UIColor orangeColor];
        lable.font = [UIFont systemFontOfSize:13];
        [self addSubview:lable];
        
        _commodityDiscountPriceLable = lable;
    }
    
    return _commodityDiscountPriceLable;
}

- (UILabel *)commodityPriceLable
{
    if (!_commodityPriceLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(self.commodityNameLable.x, CGRectGetMaxY(self.commodityDiscountPriceLable.frame), self.commodityNameLable.width, 20);
        lable.numberOfLines = 1;
        lable.font = [UIFont systemFontOfSize:13];
        [self addSubview:lable];
        
        _commodityPriceLable = lable;
    }
    
    return _commodityPriceLable;
}

- (UILabel *)commodityNumberLable
{
    if (!_commodityNumberLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(self.commodityPriceLable.x, CGRectGetMaxY(self.commodityPriceLable.frame), self.commodityNameLable.width, self.commodityPriceLable.height);
        lable.numberOfLines = 1;
        lable.font = self.commodityPriceLable.font;
        [self addSubview:lable];
        
        _commodityNumberLable = lable;
    }
    
    return _commodityNumberLable;
}

- (UILabel *)commodityBrandLable
{
    if (!_commodityBrandLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(self.commodityNumberLable.x, CGRectGetMaxY(self.commodityNumberLable.frame), self.commodityNumberLable.width, self.commodityNumberLable.height);
        lable.numberOfLines = 1;
        lable.font = self.commodityNumberLable.font;
        [self addSubview:lable];
        
        _commodityBrandLable = lable;
    }
    
    return _commodityBrandLable;
}

- (UILabel *)commodityUnitLable
{
    if (!_commodityUnitLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(self.commodityBrandLable.x, CGRectGetMaxY(self.commodityBrandLable.frame), self.commodityBrandLable.width, self.commodityBrandLable.height);
        lable.numberOfLines = 1;
        lable.font = self.commodityBrandLable.font;
        [self addSubview:lable];
        
        _commodityUnitLable = lable;
    }
    
    return _commodityUnitLable;
}

- (UILabel *)commodityAmountLable
{
    if (!_commodityAmountLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(self.commodityUnitLable.x, CGRectGetMaxY(self.commodityUnitLable.frame), self.commodityUnitLable.width, self.commodityUnitLable.height);
        lable.numberOfLines = 1;
        lable.font = self.commodityUnitLable.font;
        [self addSubview:lable];
        
        _commodityAmountLable = lable;
    }
    
    return _commodityAmountLable;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    LQCommodityCell *cell = [[LQCommodityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setContent:(LQNewsContent *)content
{
    _content = content;
    
    [self.commodityImageView sd_setImageWithURL:[NSURL URLWithString:content.productpic] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    self.commodityNameLable.text = content.title;
    self.commodityDiscountPriceLable.text = [NSString stringWithFormat:@"优惠价：￥%@",content.tprice];
    self.commodityPriceLable.text = [NSString stringWithFormat:@"市场价：￥%@  点数：%@",content.price,content.buyfen];
    self.commodityNumberLable.text = [NSString stringWithFormat:@"商品编号：%@",content.productno];
    self.commodityBrandLable.text = [NSString stringWithFormat:@"商品品牌：%@",content.pbrand];
    self.commodityUnitLable.text = [NSString stringWithFormat:@"商品单位：%@",content.unit];
    self.commodityAmountLable.text = [NSString stringWithFormat:@"商品重量：%@",content.weight];
}

@end
