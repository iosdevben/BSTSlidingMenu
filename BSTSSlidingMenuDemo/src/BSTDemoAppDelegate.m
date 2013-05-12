//
//  BSTDemoAppDelegate.m
//  Demo
//
//  Created by Ben Thomas on 10/05/13.
//  Copyright (c) 2013 Ben Thomas. All rights reserved.
//

#import "BSTDemoAppDelegate.h"
#import "BSTDemoViewController.h"

@implementation BSTDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#pragma unused(launchOptions, application)
    
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  self.window.rootViewController = [[BSTDemoViewController alloc] initWithNibName:nil bundle:nil];
  [self.window makeKeyAndVisible];
  
  return YES;
}

@end
