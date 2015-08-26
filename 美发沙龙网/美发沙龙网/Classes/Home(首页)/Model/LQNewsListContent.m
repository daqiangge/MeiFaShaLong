//
//  LQNewsListContent.m
//  美发沙龙网
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewsListContent.h"

@implementation LQNewsListContent

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id",
             @"titlename":@"title"};
}

- (NSString *)titlepicurl
{
    if ([self.table isEqualToString:@"movie"])
    {
        return _titlepicurl;
    }
    else if ([self.table isEqualToString:@"news"])
    {
        return [NSString stringWithFormat:@"http://old.meifashalong.com%@",_titlepicurl];
    }
    
    return _titlepicurl;
}

@end
