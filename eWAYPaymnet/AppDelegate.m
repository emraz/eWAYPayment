//
//  AppDelegate.m
//  eWAYPaymnet
//
//  Created by Mahmudul Hasan R@zib on 10/20/17.
//  Copyright © 2017 Matrix Solution. All rights reserved.
//

#import "AppDelegate.h"
#import "RapidAPI.h"

#define Sandbox @"https://api.sandbox.ewaypayments.com/"
#define Production @"https://api.ewaypayments.com/"
#define API_KEY @"epk-4A576978-9E3F-404F-9CBC-A563B93351FF"

//Test Credit Card Details
//https://go.eway.io/s/article/Test-Credit-Card-Numbers

//Documentation
//https://www.eway.com.au/developers/sdk

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[RapidAPI sharedManager] setRapidEndpoint:Production];
    [[RapidAPI sharedManager] setPublicAPIKey:API_KEY];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
