//
//  LQNewsList.m
//  美发沙龙网
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewsList.h"

@implementation LQNewsList

+ (NSDictionary *)objectClassInArray
{
    return @{@"data":@"LQNewsListContent"};
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"data":@"data[0]"};
}

@end


