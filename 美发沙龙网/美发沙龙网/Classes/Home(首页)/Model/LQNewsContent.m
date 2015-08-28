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
    return @{@"title":@"data.content.title",
             @"newstext":@"data.content.newstext",
             @"ID":@"data.content.id",
             @"classid":@"data.content.classid",
             @"tprice":@"data.content.tprice",
             @"price":@"data.content.price",
             @"buyfen":@"data.content.buyfen",
             @"pmaxnum":@"data.content.pmaxnum",
             @"pbrand":@"data.content.pbrand",
             @"unit":@"data.content.unit",
             @"weight":@"data.content.weight",
             @"productno":@"data.content.productno",
             @"productpic":@"data.content.productpic"};
}

@end


