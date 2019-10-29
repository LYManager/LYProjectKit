// AppDelegate.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "AppDelegate.h"
#import "LYPageContext.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LYAVOSCloudManager.h"
static NSString * const kAppId = @"lSKy6cV4UGpBNoSAeoVJmwGF-gzGzoHsz";
static NSString * const kAppKey = @"hYVKTmQ7XheQdwUIawAHb1Ux";
@interface AppDelegate ()
/**< <#des#>*/

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self _setupWindow];
    [self configProgressHUD];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
           switch (status) {
               case AFNetworkReachabilityStatusReachableViaWWAN:
                   break;
               case AFNetworkReachabilityStatusReachableViaWiFi:
                   break;
               case AFNetworkReachabilityStatusNotReachable:
                   [self.window makeToast:@"请检查网络连接" duration:2 position:CSToastPositionCenter];
                   break;
               case AFNetworkReachabilityStatusUnknown:
                    [self.window makeToast:@"请检查网络连接" duration:2 position:CSToastPositionCenter];
                   break;
               default:
                   break;
           }
       }];
    
    [[LYAVOSCloudManager shareInstance]registerCloud];
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

#pragma mark🐒------public------🐒
- (void)showLogin
{
    //    BTGLoginVC *loginVC = [[BTGLoginVC alloc] init];
    //    MCLoginVC * loginVC = [[MCLoginVC alloc] init];
    
//    StarFirstLoginVC * loginVC = [StarFirstLoginVC new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [nav.navigationBar setTranslucent:NO];
//    self.window.rootViewController = nav;
}

#pragma mark🐒------Private 私有方法------🐒
- (void)_setupWindow
{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[LYPageContext shareInstance] setupLoginViewController];
}

- (void) configProgressHUD{
    [LYProgressHUD startDefaultConfig];
}

@end
