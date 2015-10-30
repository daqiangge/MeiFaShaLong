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

- (NSString *)briefIntroduction
{
    _briefIntroduction = @"所需点数：\n上传时间：\n影片类型：\n影片简介：";
    return _briefIntroduction;
}

- (NSString *)useHelp
{
    _useHelp = @"1.为什么要成为VIP会员？自助注册的会员为普通会员，并不是VIP会员，是无法观看VIP完整视频的，所以观看完整视频请联系客服升级为VIP会员，成为VIP会员即可观看本站几千集完整版教学视频，国内外名师为您详细讲解剪，烫，染，吹风造型，盘发扎发，美发店经营管理，使您足不出户就能了解最新的潮流趋势，最新优惠详情请咨询本站客服QQ800030206 电话0510-66651781\n2.如何购买VIP卡？自助注册的会员为普通会员，并不是VIP会员，是无法观看VIP完整视频的，所以观看完整视频请联系客服升级为VIP会员，成为VIP会员即可观看本站几千集完整版教学视频，国内外名师为您详细讲解剪，烫，染，吹风造型，盘发扎发，美发店经营管理，使您足不出户就能了解最新的潮流趋势，最新优惠详情请咨询本站客服QQ800030206 电话0510-66651781";
    
    return _useHelp;
}

@end
