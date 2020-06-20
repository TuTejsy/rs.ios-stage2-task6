//
//  AppDelegate.m
//  Task6
//
//  Created by Vasil' on 6/19/20.
//  Copyright © 2020 Vasil'. All rights reserved.
//

#import "AppDelegate.h"
#import "VHStartViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.rootViewController = [self rootViewController];
    
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIViewController *)rootViewController {
    VHStartViewController *viewController = [[VHStartViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    return navigationController;
}


@end
