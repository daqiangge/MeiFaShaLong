//
//  LQHomeRollingScrollView.m
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//


#import "LQHomeRollingScrollView.h"
#import "LQNewsListContent.h"

@interface LQHomeRollingScrollView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *previousImageView;
@property (nonatomic, weak) UIImageView *nextImageView;
@property (nonatomic, weak) UIImageView *currentImageView;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int count;

@end

@implementation LQHomeRollingScrollView


+ (instancetype)homeRollingScrollViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        
        self.page = 0;
        self.count = 5;
        
        [self doLoading];
        
    }
    
    return self;
}

- (void)setImageUrlArray:(NSMutableArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    
    [self.currentImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlArray[self.page] titlepicurl]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    
    if (self.page == 0)
    {
        [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlArray[self.page + 1] titlepicurl]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
        [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlArray[4] titlepicurl]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    }
    else if (self.page < 4)
    {
        [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlArray[self.page + 1] titlepicurl]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
        [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlArray[self.page - 1] titlepicurl]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    }
    else if (self.page == 4)
    {
        [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlArray[1] titlepicurl]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
        [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlArray[self.page - 1] titlepicurl]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    }
    
    //更改小圆点的位置及标题
    if ([self.homeRollingScrollViewDelegate respondsToSelector:@selector(homeRollingScrollViewDidUpdatePageControl:currentPage:titleName:)]) {
        [self.homeRollingScrollViewDelegate homeRollingScrollViewDidUpdatePageControl:self currentPage:self.page titleName:[imageUrlArray[self.page] titlename]];
    }
}

- (void)doLoading
{
    self.contentSize = CGSizeMake(LQScreen_Width * 3, self.height);
    self.contentOffset = CGPointMake(LQScreen_Width, 0);
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    
    [self addImageView];
}

- (void)addImageView
{
    for (int i = 0; i < 3; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(LQScreen_Width * i, 0, LQScreen_Width, self.height);
        imageView.image = [UIImage imageNamed:@"placehodeImage"];
        [self addSubview:imageView];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, imageView.width, imageView.height);
        [btn addTarget:self action:@selector(clickImageView:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        
        switch (i)
        {
            case 0:
            {
                self.previousImageView = imageView;
//                [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[kCount - 1]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
            }
                break;
                
            case 1:
            {
                self.currentImageView = imageView;
//                [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[0]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
            }
                break;
                
            case 2:
            {
                self.nextImageView = imageView;
//                [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[1]] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
            }
                break;
        }
    }
}

- (void)nextImage
{
    CGFloat offestX = self.contentOffset.x + LQScreen_Width;
    CGPoint offest = CGPointMake(offestX, 0);
    [self setContentOffset:offest animated:YES];
}

/**
 *  点击了图片
 */
- (void)clickImageView:(UIButton *)btn
{
    if ([self.homeRollingScrollViewDelegate respondsToSelector:@selector(homeRollingScrollViewDidClickImageView:newsListContent:)])
    {
        LQNewsListContent *newListContent = self.imageUrlArray[self.page];
        [self.homeRollingScrollViewDelegate homeRollingScrollViewDidClickImageView:self newsListContent:newListContent];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offestX = scrollView.contentOffset.x;
    
    if (self.previousImageView.image == nil || self.nextImageView.image == nil)
    {
        LQNewsListContent *previouCcontent = self.imageUrlArray[self.page == 0 ? self.count - 1:self.page - 1];
        LQNewsListContent *nextCcontent = self.imageUrlArray[self.page == self.count - 1 ? 0 : self.page + 1];
        
        [self.previousImageView sd_setImageWithURL:[NSURL URLWithString:previouCcontent.titlepicurl] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
        [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:nextCcontent.titlepicurl] placeholderImage:[UIImage imageNamed:@"placehodeImage"]];
    }
    
    if (offestX == 0)
    {
        self.currentImageView.image = self.previousImageView.image;
        scrollView.contentOffset = CGPointMake(LQScreen_Width, 0);
        self.previousImageView.image = nil;
        
        if (self.page == 0)
        {
            self.page = self.count - 1;
        }else
        {
            self.page -= 1;
        }
    }
    
    if (offestX == LQScreen_Width*2)
    {
        self.currentImageView.image = self.nextImageView.image;
        scrollView.contentOffset = CGPointMake(LQScreen_Width, 0);
        self.nextImageView.image = nil;
        
        if (self.page == self.count - 1)
        {
            self.page = 0;
        }else
        {
            self.page += 1;
        }
    }
    
    //更改小圆点的位置及标题
    if ([self.homeRollingScrollViewDelegate respondsToSelector:@selector(homeRollingScrollViewDidUpdatePageControl:currentPage:titleName:)]) {
        LQNewsListContent *content = self.imageUrlArray[self.page];
        [self.homeRollingScrollViewDelegate homeRollingScrollViewDidUpdatePageControl:self currentPage:self.page titleName:content.titlename];
    }
}

@end
