//
//  LQNewsContent.m
//  美发沙龙网
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewsContent.h"

@implementation LQNewsContent

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"title":@"data.content.title",@"newstext":@"data.content.newstext"};
}

@end


