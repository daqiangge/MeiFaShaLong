//
//  LQVideoNumberVC.h
//  美发沙龙网
//
//  Created by admin on 15/8/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KNotificationName_VideoBtnSelecteNum @"KNotificationName_VideoBtnSelecteNum"

@interface LQVideoNumberVC : UIViewController

//视频集数
@property (nonatomic, assign) int totalpath;

/**
 *  记录播放的第几集
 */
@property (nonatomic, assign) int videoBtnSelecteNum;



@end
