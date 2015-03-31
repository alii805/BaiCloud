//
//  AppDelegate.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/11/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LocationManager.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic,strong) NSString *databaseName;

@property (nonatomic,strong) NSString *databasePath;

@end
