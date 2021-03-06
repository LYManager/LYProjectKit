// LYPageContext.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYPageContext.h"
/** Base*/
#import "LYBaseViewController.h"
#import "LYTabBarViewController.h"
#import "LYNavigationViewController.h"
/** 页面 */
#import "LYHomePageViewController.h"
/** 数据 */
#import "LYTabBarData.h"

#import "LYHomeViewController.h"
#import "LYNavigationViewController.h"
#import "LoginViewController.h"

#import "LYWorkViewController.h"
@implementation LYPageContext
+ (instancetype)shareInstance
{
    static LYPageContext *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LYPageContext alloc] init];
        UIImage *backButtonImage = [[UIImage imageNamed:@"back_icon"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 140, 0, 0) resizingMode:UIImageResizingModeTile];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin,NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    });
    return instance;
}



- (void)setupMainViewController
{
    
    
    LYWorkViewController * loginVC = [[LYWorkViewController alloc]init];
//    loginVC.hideNavigationBar = YES;
    LYNavigationViewController * navc = [[LYNavigationViewController alloc]initWithRootViewController:loginVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = navc;
}

- (void)setupLoginViewController{
     [self setupMainViewController];
    return;
    
//    如果有值，登录过
    if ([LYUserDefault shareInstance].userInfoDict) {
        [LYUserInfoManager shareInstance].userInfo = [LYUserInfo modelWithDictionary:[LYUserDefault shareInstance].userInfoDict[@"data"]];
        [self setupMainViewController];
        return;
    }
    LoginViewController * loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    loginVC.hideNavigationBar = YES;
    LYNavigationViewController * navc = [[LYNavigationViewController alloc]initWithRootViewController:loginVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = navc;
}

- (void)_configDataTabBarVC:(LYTabBarViewController *)tabBarVC
{
    /** 默认字体颜色 */
    NSDictionary *textAttrs = @{NSForegroundColorAttributeName:[UIColor grayColor]};
    /** 选择字体颜色 */
    NSDictionary *selectTextAttrs = @{NSForegroundColorAttributeName:[UIColor redColor]};
    [tabBarVC.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.title = NSLocalizedString(LYTabBarItemTitleKeys[idx], nil);
        NSString * defaultImageName = LYTabBarItemImageNames[idx];
        obj.image = [[UIImage imageNamed:defaultImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        obj.selectedImage = [[UIImage imageNamed:select_image_name(idx)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [obj setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [obj setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    }];
}


- (LYNavigationViewController *)_getNavcWithCurrentVC:(LYBaseViewController *)currentVC
{
    LYNavigationViewController * navc = [[LYNavigationViewController alloc]initWithRootViewController:currentVC];
    return navc;
}


@end
