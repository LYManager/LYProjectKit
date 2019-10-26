// LYNavigationViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 
// <#Class des#>
#import "LYNavigationViewController.h"
#import "UIColor+Extention.h"
#import <AFNetworking.h>
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
   AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusNotReachable) {
        [self.view makeToast:@"请检查网络连接" duration:2 position:CSToastPositionCenter];

        return;
    }
    if (self.childViewControllers.count > 0) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        backItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        viewController.navigationItem.leftBarButtonItem = backItem;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    self.interactivePopGestureRecognizer.delegate = nil;
}
- (void) back {
    [self popViewControllerAnimated:YES];
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
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarTintColor:[UIColor ly_colorWithHexString:@"#0E1018"]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
    NSFontAttributeName : [UIFont systemFontOfSize:17]}];
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
