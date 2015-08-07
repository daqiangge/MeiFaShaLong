//
//  LQInformationTableViewCell.m
//  美发沙龙网
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQInformationTableViewCell.h"

@interface LQInformationTableViewCell()

@property (nonatomic, weak) UIImageView *numLableImageView;

@end

@implementation LQInformationTableViewCell

- (UIImageView *)titleImageView
{
    if (_titleImageView == nil)
    {
        CGFloat x = 12.5;
        CGFloat y = 14;
        CGFloat width = 67;
        CGFloat height = cell_height - 2 * y;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UIImageView *titleImageView = [[UIImageView alloc] init];
        titleImageView.frame = frame;
        titleImageView.image = [UIImage imageNamed:@"placehodeImage"];
        [self addSubview:titleImageView];
        
//        [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).with.offset(12.5);
//            make.top.equalTo(self.mas_top).with.offset(14);
//            make.bottom.equalTo(self.mas_bottom).with.offset(-14);
//            make.width.equalTo(@67);
//        }];
        
        _titleImageView = titleImageView;
    }
    
    return _titleImageView;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        CGFloat x = CGRectGetMaxX(self.titleImageView.frame) + 10;
        CGFloat y = CGRectGetMinY(self.titleImageView.frame);
        CGFloat width = self.width - x - 40;
        CGFloat height = 34;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.numberOfLines = 2;
        lable.font = [UIFont systemFontOfSize:13];
        lable.textColor = [UIColor blackColor];
        [self addSubview:lable];
        
//        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.titleImageView.mas_top).with.offset(0);
//            make.left.equalTo(self.titleImageView.mas_right).with.offset(10);
//            make.right.equalTo(self.mas_right).with.offset(-20);
//            make.height.equalTo(@36);
//        }];
        
        _titleLable = lable;
        
    }
    
    return _titleLable;
}

- (UILabel *)dateLable
{
    if (_dateLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = RGB(182, 182, 182);
        lable.font = [UIFont systemFontOfSize:10];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLable.mas_left).with.offset(0);
            make.bottom.equalTo(self.titleImageView.mas_bottom).with.offset(0);
            make.width.equalTo(@150);
            make.height.equalTo(@10);
        }];
        _dateLable = lable;
    }
    
    return _dateLable;
}

- (UILabel *)numLable
{
    if (_numLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = self.dateLable.textColor;
        lable.font = [UIFont systemFontOfSize:8];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-12.5);
            make.bottom.equalTo(self.dateLable.mas_bottom).with.offset(0);
            make.height.equalTo(@8);
            make.width.equalTo(@15);
        }];
        _numLable = lable;
        
    }
    
    return _numLable;
}

- (UIImageView *)numLableImageView
{
    if (_numLableImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"placehodeImage"];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.numLable.mas_left).with.offset(-2);
            make.bottom.equalTo(self.titleImageView.mas_bottom).with.offset(0);
            make.height.equalTo(@10);
            make.width.equalTo(@10);
        }];
        
        _numLableImageView = imageView;
    }
    return _numLableImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self doLoading];
    }
    return self;
}

+ (LQInformationTableViewCell *)cellWithTableView:(UITableView *)tableView 
{
    static NSString *idenifier = @"LQInformationTableViewCell";
    LQInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQInformationTableViewCell"];
    if (cell == nil) {
        cell = [[LQInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
    }
    
    return cell;
}

- (void)doLoading
{
    self.titleImageView.hidden = NO;
    self.titleLable.hidden = NO;
    self.dateLable.hidden = NO;
    self.numLable.hidden = NO;
    self.numLableImageView.hidden = NO;
}

- (void)setListContent:(LQNewsListContent *)listContent
{
    _listContent = listContent;
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:listContent.titlepicurl] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    
    self.titleLable.text = listContent.titlename;
    self.dateLable.text = listContent.newstime;
    self.numLable.text = listContent.onclick;
    
    CGSize titleLableSize = [self.titleLable.text calculateStringSizeWithMaxSize:CGSizeMake(self.titleLable.width, MAXFLOAT) font:self.titleLable.font];
    self.titleLable.height = titleLableSize.height;
}

@end
