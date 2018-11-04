//
//  AppDelegate.m
//  CanapTV
//
//  Created by Cyril Delamare on 01/05/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterView.h"
#import "FilterView.h"
#import "InfosView.h"
#import "ChainesView.h"
#import "DetailView.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    DetailView * detailVC = [[DetailView alloc] init];
    MasterView * masterVC = [[MasterView alloc] init];
    InfosView * infosVC = [[InfosView alloc] init];
    ChainesView * chainesVC = [[ChainesView alloc] init];
    FilterView * filterVC = [[FilterView alloc] init];
    
    UITabBarController * tabVC = [[UITabBarController alloc] init];
    masterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Custom" image:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/106-sliders.png"]] tag:0];
    filterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Filtres" image:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/20-gear2.png"]] tag:0];
    chainesVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Chaines" image:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/70-tv.png"]] tag:0];
    infosVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Infos" image:[[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/icones/81-dashboard.png"]] tag:0];
    tabVC.viewControllers = [NSArray arrayWithObjects:masterVC, filterVC, chainesVC, infosVC, nil];
    
    UISplitViewController * splitVC = [[UISplitViewController alloc] init];
    [splitVC setViewControllers:[NSArray arrayWithObjects:tabVC, detailVC, nil]];
    [self.window setRootViewController:splitVC]; 
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
