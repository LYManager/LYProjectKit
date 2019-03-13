// LYBaseViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
// <#Class des#>
#import "LYBaseViewController.h"

@interface LYBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation LYBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    
    NSLog(@"传过来的参数 ======  %@",self.params);
//    self.navigationController.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Life

#pragma mark - Public Methods
- (void)pushViewControllerWithClassName:(NSString *)controllerName params:(NSDictionary *)params
{
    LYBaseViewController *vc = (LYBaseViewController *)[[(NSClassFromString(controllerName))alloc]init];
    vc.params = params;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Notification

#pragma mark - Delegate
//  UINavigationControllerDelegate <控制导航栏是否隐藏>
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(LYBaseViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        return;
    }
    navigationController.delegate = viewController;//防止有的失效
    [self.navigationController setNavigationBarHidden:viewController.isHideNavigationBar animated:YES];
}
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










/// 配置UI
@implementation LYBaseViewController (ConfigUI)
// @start 设置状态栏颜色
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    [UIView animateWithDuration:0.3 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}
// @end

- (void)setHideStatusBar:(BOOL)hideStatusBar
{
    _hideStatusBar = hideStatusBar;
    self.view.window.windowLevel = hideStatusBar ? UIWindowLevelStatusBar + 1 : UIWindowLevelNormal;
}

- (void)setStatusBarBackgroundColor:(UIColor *)statusBarBackgroundColor
{
    _statusBarBackgroundColor = statusBarBackgroundColor;
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = statusBarBackgroundColor;
    }
}
@end
