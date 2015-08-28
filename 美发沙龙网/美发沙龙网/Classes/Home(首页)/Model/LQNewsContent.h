//
//  LQNewsContent.h
//  美发沙龙网
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQNewsContent : NSObject

@property (nonatomic, copy) NSString *newstext;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *classid;
@property (nonatomic, copy) NSString *tprice;//优惠价
@property (nonatomic, copy) NSString *price;//市场价
@property (nonatomic, copy) NSString *buyfen;//点数
@property (nonatomic, copy) NSString *pmaxnum;//数量
@property (nonatomic, copy) NSString *pbrand;//品牌
@property (nonatomic, copy) NSString *unit;//单位
@property (nonatomic, copy) NSString *weight;//重量
@property (nonatomic, copy) NSString *productno;//编号
@property (nonatomic, copy) NSString *productpic;//产品图片


@end
