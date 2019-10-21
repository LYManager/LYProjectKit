// LYRouterManager.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/8/5. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYRouterManager.h"
#import <MGJRouter.h>

#import "LYTestWebViewController.h"
#import "LYMineViewController.h"
#import "LYSafeSettingViewController.h"
#import "LYMayiGongHuiViewController.h"
#import "LYShengTaiViewController.h"
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
    
    [MGJRouter registerURLPattern:@"mayiGHVC" toHandler:^(NSDictionary *routerParameters) {
              LYMayiGongHuiViewController *vc = [[LYMayiGongHuiViewController alloc]initWithNibName:@"LYMayiGongHuiViewController" bundle:NSBundle.mainBundle];;
              UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
              void(^block)(id result) = routerParameters[MGJRouterParameterCompletion];
              !block ?: block(@"完成");
              [navigationVC pushViewController:vc animated:YES];
          }];
    [MGJRouter registerURLPattern:@"shengTaiVC" toHandler:^(NSDictionary *routerParameters) {
        LYShengTaiViewController *vc = [[LYShengTaiViewController alloc]initWithNibName:@"LYShengTaiViewController" bundle:NSBundle.mainBundle];;
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        void(^block)(id result) = routerParameters[MGJRouterParameterCompletion];
        !block ?: block(@"完成");
        [navigationVC pushViewController:vc animated:YES];
    }];
    
    
}
@end
