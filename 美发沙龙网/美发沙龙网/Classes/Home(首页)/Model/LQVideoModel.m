//
//  LQVideoModel.m
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoModel.h"

@implementation LQVideoModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"title":@"data.title",
             @"ID":@"data.id",
             @"classid":@"data.classid",
             @"classname":@"data.classname",
             @"tbname":@"data.tbname",
             @"onlinepath":@"data.onlinepath",
             @"totalpath":@"data.totalpath"};
}

@end
