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
    //添加强制更新
    [self forcedToUpdate];
    
    
    return YES;
}
-(void)forcedToUpdate
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    [LYNetwork POSTWithApiPath:forcedURL requestParams:@{
        @"appType":@"1",
        @"version":app_Version,
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
        
        NSString *url = [[response objectForKey:@"data"] objectForKey:@"url"];
        NSString *force_update = [[response objectForKey:@"data"] objectForKey:@"force_update"];
        NSString *title = [[response objectForKey:@"data"] objectForKey:@"tip"];

        if ([force_update isEqualToString:@"Y"]) {//强制更新
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSURL *urlStr = [NSURL URLWithString:url];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([[UIApplication sharedApplication] canOpenURL:urlStr]) {
                        [[UIApplication sharedApplication] openURL:urlStr];
                        [self exitApplication ];
                    }
                });
            }];
            // 添加取消按钮才能点击空白隐藏
            [alertController addAction:OKAction];
            UIWindow   *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            alertWindow.rootViewController = [[UIViewController alloc] init];
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            [alertWindow makeKeyAndVisible];
            [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

        }
        if ([force_update isEqualToString:@"N"]) {//非强制更新
             
            
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
           
            UIAlertAction *cancalBtn  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
           UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
               NSURL *urlStr = [NSURL URLWithString:url];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   if ([[UIApplication sharedApplication] canOpenURL:urlStr]) {
                       [[UIApplication sharedApplication] openURL:urlStr];
                       [self exitApplication ];
                   }
               });
           }];
            
           // 添加取消按钮才能点击空白隐藏
            [alertController addAction:cancalBtn];
           [alertController addAction:OKAction];

           UIWindow   *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
           alertWindow.rootViewController = [[UIViewController alloc] init];
           alertWindow.windowLevel = UIWindowLevelAlert + 1;
           [alertWindow makeKeyAndVisible];
           [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

       }


    }];
}
- (void)exitApplication {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    // 动画 1
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    //exit(0);
    
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
