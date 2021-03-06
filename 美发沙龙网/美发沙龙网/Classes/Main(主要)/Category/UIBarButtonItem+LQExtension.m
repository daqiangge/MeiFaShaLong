//
//  UIBarButtonItem+LQExtension.m
//  美发沙龙网
//
//  Created by admin on 15/7/23.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "UIBarButtonItem+LQExtension.h"

@implementation UIBarButtonItem (LQExtension)

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (NSArray *)barbarButtonItemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action space:(int)space
{
    
    UIBarButtonItem *BarButton = [UIBarButtonItem barButtonItemWithImageName:imageName selectedImageName:selectedImageName target:target action:action];
    //调整间距
    UIBarButtonItem *navigationSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigationSpacer.width = space;
    
    return [NSArray arrayWithObjects:navigationSpacer,BarButton, nil];
}

@end
