//
//  MFAppDelegate.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.
//

#import <UIKit/UIKit.h>
#import "MFSideMenuContainerViewController.h"

@interface MFAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) MFSideMenuContainerViewController *container;

@property (strong, nonatomic) UIWindow *window;

@end
