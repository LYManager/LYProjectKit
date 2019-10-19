// LYRouterManager.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/8/5. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYRouterManager.h"
#import <MGJRouter.h>
#import "LYFindViewController.h"
#import "LYTestWebViewController.h"
#import "LYMineViewController.h"
#import "LYSafeSettingViewController.h"
@implementation LYRouterManager
+ (void)load{
    [MGJRouter registerURLPattern:@"mineVC" toHandler:^(NSDictionary *routerParameters) {
        LYMineViewController *vc = [[LYMineViewController alloc]initWithNibName:@"LYMineViewController" bundle:NSBundle.mainBundle];;
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        void(^block)(id result) = routerParameters[MGJRouterParameterCompletion];
        !block ?: block(@"完成");
        [navigationVC pushViewController:vc animated:YES];
    }];
    
    [MGJRouter registerURLPattern:@"safeSettingVC" toHandler:^(NSDictionary *routerParameters) {
           LYSafeSettingViewController *vc = [[LYSafeSettingViewController alloc]initWithNibName:@"LYSafeSettingViewController" bundle:NSBundle.mainBundle];;
           UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
           void(^block)(id result) = routerParameters[MGJRouterParameterCompletion];
           !block ?: block(@"完成");
           [navigationVC pushViewController:vc animated:YES];
       }];
}
@end
