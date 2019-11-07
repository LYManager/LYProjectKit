// LYBaseViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 
// <#Class des#>
#import "LYBaseViewController.h"
// 购买弹框
#import "LYPayPopViewController.h"
#import "LYPopToolsViewController.h" // 使用道具
#import "LYPopSendToolsViewController.h"
#import "LYPopErrorViewController.h"
#import "LYPopConfirmViewController.h"
#import "LYPopTradePwdViewController.h"
@interface LYBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation LYBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)loadRequest{}

#pragma mark - Life
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - Public Methods
- (void)pushViewControllerWithClassName:(NSString *)controllerName params:(NSDictionary *)params
{
    if (controllerName.length == 0) {
        [self.view makeToast:@"功能正在开发中..." duration:2 position:CSToastPositionCenter];
        return;
    }
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
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        return;
    }
    navigationController.delegate = viewController;//防止有的失效
    [self.navigationController setNavigationBarHidden:viewController.isHideNavigationBar animated:YES];
}

#pragma mark🐒------弹框------     使用时候强转对应vc🐒
- (void)popBuyController:(LYTaskCardModel *)cardModel{
    LYPayPopViewController *vc = (LYPayPopViewController *)[self _getPopVC:@"LYPayPopViewController"];
    vc.model = cardModel;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)popToolsController:(LYAntCardModel *)antTaskModel callBack:(nullable void (^)(NSString * _Nonnull))callBack{
    [self popToolsController:antTaskModel isRealCheck:NO callBack:callBack];
}
- (void) popToolsController:(LYAntCardModel *)antTaskModel isRealCheck:(BOOL)isRealCheck callBack:(nullable void(^)(NSString *))callBack{
    LYPopToolsViewController *vc = (LYPopToolsViewController *)[self _getPopVC:@"LYPopToolsViewController"];
       vc.cardModel = antTaskModel;
    vc.isRealCheck = isRealCheck;
   if (antTaskModel.cardId == 1) {
       vc.callBack = callBack;
   }
  [self.navigationController presentViewController:vc animated:YES completion:nil];
}


- (void)popSendToolsController:(LYAntCardModel *)antTaskModel backBlock:(nonnull void (^)(void))backBlock{
     LYPopSendToolsViewController *vc = (LYPopSendToolsViewController *)[self _getPopVC:@"LYPopSendToolsViewController"];
    vc.cardModel = antTaskModel;
    vc.backBlock = backBlock;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}


- (void)popErrorControllerIsSend:(BOOL)isSend isRealNameCard:(BOOL)isRealNameCard{
    LYPopErrorViewController *vc = (LYPopErrorViewController *)[self _getPopVC:@"LYPopErrorViewController"];
    vc.isSend = isSend;
    vc.isRealNameCard = isRealNameCard;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)popConfirmControllerType:(ConfirmType)type backBlock:(BackBlock)backBlock{
    LYPopConfirmViewController * vc = (LYPopConfirmViewController *)[self _getPopVC:@"LYPopConfirmViewController"];
    [vc configDataWithType:type callBack:backBlock];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) popTradePwdControllerType:(TradePopType)type AGC:(NSString *)agc CNY:(NSString *)cny backBlock:(TradeCallBack)backBlock{
    LYPopTradePwdViewController * vc = (LYPopTradePwdViewController *)[self _getPopVC:@"LYPopTradePwdViewController"];
    [vc configDataWithType:type AGC:agc CNY:cny callBack:backBlock];
    [self presentViewController:vc animated:YES completion:nil];
}

- (LYBaseViewController *)_getPopVC:(NSString *)popName{
     LYBaseViewController * vc = [[NSClassFromString(popName) alloc]initWithNibName:popName bundle:NSBundle.mainBundle];
    vc.forbidConfigBgColor = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
       vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    return vc;
}

- (void)setForbidConfigBgColor:(BOOL)forbidConfigBgColor{
    _forbidConfigBgColor = forbidConfigBgColor;
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
