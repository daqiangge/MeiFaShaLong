//
//  LQAdvertisements.m
//  美发沙龙网
//
//  Created by liqiang on 15/10/31.
//  Copyright © 2015年 美发沙龙网. All rights reserved.
//

#import "LQAdvertisements.h"

@implementation LQAdvertisements

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"advertisements":@"data[0]"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"advertisements":@"LQAdvertisement"};
}

@end
