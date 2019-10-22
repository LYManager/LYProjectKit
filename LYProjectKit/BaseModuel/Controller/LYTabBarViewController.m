// LYTabBarViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 
// <#Class des#>
#import "LYTabBarViewController.h"

@interface LYTabBarViewController ()

@end

@implementation LYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Life

#pragma mark - Public Methods
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.selectedViewController;
}

#pragma mark - Notification

#pragma mark - Delegate

#pragma mark - Private Methods

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
