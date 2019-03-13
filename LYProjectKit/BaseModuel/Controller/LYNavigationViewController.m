// LYNavigationViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
// <#Class des#>
#import "LYNavigationViewController.h"

@interface LYNavigationViewController ()

@end

@implementation LYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
}

#pragma mark - Life
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
#pragma mark - Public Methods
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}



#pragma mark - Notification

#pragma mark - Delegate

#pragma mark - Private Methods

/**
 初始配置
 */
- (void)initConfig
{
    [self.navigationBar setBarTintColor:[UIColor darkGrayColor]];
}
#pragma mark - Lazy

#pragma mark - dealloc
- (void) dealloc
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
