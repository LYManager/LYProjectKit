// LYPageContext.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
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

@implementation LYPageContext
+ (instancetype)shareInstance
{
    static LYPageContext *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LYPageContext alloc] init];
    });
    return instance;
}



- (void)setupMainViewController
{
    NSArray * controllers = controllerArray();
    NSMutableArray * navcs = [NSMutableArray array];
    [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LYBaseViewController * vc = [((Class)obj) new];
        LYNavigationViewController *navc = [self _getNavcWithCurrentVC:vc];
        [navcs addObject:navc];
    }];
    
    LYTabBarViewController * tabBarVC = [[LYTabBarViewController alloc]init];
    tabBarVC.viewControllers = navcs;
    [self _configDataTabBarVC:tabBarVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
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
