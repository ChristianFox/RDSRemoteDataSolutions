//
//  DEMOAppDelegate.m
//  RDSRemoteDataSolutions
//
//  Created by Christian Fox on 10/29/2016.
//  Copyright (c) 2016 Christian Fox. All rights reserved.
//

#import "DEMOAppDelegate.h"
// Pods
#import <KFXLog/KFXLogConfigurator.h>
#import <KFXLog/KFXLog.h>

@implementation DEMOAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self configureKFXLog];
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




-(void)configureKFXLog{
    
    KFXLogConfigurator *config = [KFXLogConfigurator sharedConfigurator];
    config.buildConfiguration = KFXBuildConfigurationDebug;
    config.shouldLogUncaughtExceptions = YES;
    config.consoleLogType = KFXConsoleLogTypeClean;
    config.debugLogMediums = KFXLogMediumConsole;
//    config.adHocLogMediums =  KFXLogMedium;
//    config.releaseLogMediums = KFXLogMediumFile | KFXLogMediumService;
    config.shouldLogUncaughtExceptions = YES;
    
    [config.cleanLogDescriptor configureWithLogFormat:KFXLogFormatFir];
    config.cleanLogDescriptor.showDate = YES;
    config.cleanLogDescriptor.maxIndent = 16;
    config.cleanLogDescriptor.order = KFXLogOrderDatePrefixIndent;
//    [config.fileLogDescriptor configureWithLogFormat:KFXLogFormatBirch];
//    config.fileLogDescriptor.indentChar = ' ';
//    config.fileLogDescriptor.maxIndent = 10;
//    config.fileLogDescriptor.showSender = KFXShowSenderClassOnly;
//    config.fileLogDescriptor.order = KFXLogOrderDatePrefixIndent;
//#if DEBUG
//    config.fileLogDescriptor.split = KFXFileLogsSplitByBuild;
//#elif ADHOC
//    config.fileLogDescriptor.split = KFXFileLogsSplitByDay;
//#else
//    config.fileLogDescriptor.split = KFXFileLogsSplitByDay;
//#endif
//    //    config.fileLogDescriptor.blacklist = KFXLogTypeMethodStart;
//    
//    [config.alertLogDescriptor configureWithLogFormat:KFXLogFormatPine];
//    //    config.alertLogDescriptor.whitelist = KFXLogTypeError | KFXLogTypeFail | KFXLogTypeWarning;
//    [config.serviceLogDescriptor configureWithLogFormat:KFXLogFormatBalsa];
//    config.serviceLogDescriptor.showSender = KFXShowSenderClassOnly;
//    config.serviceLogger = [GLCServiceLogger sharedServiceLogger];
    
    [config printSettings];
    
    [KFXLog logConfiguredObject:config sender:self];
}
















@end












