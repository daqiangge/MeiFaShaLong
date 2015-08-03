//
//  AppDelegate.h
//  美发沙龙网
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LQTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (nonatomic, strong) LQTabBarController *tabBarController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

