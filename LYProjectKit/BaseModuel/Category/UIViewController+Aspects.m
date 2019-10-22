// UIViewController+Aspects.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "UIViewController+Aspects.h"
#import <Aspects.h>
#import "UIColor+Extention.h"
#import "LYBaseViewController.h"
@implementation UIViewController (Aspects)

+ (void)load
{
    [NSClassFromString(@"LYBaseViewController") aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>acpectInfo){
         LYBaseViewController * instance = [acpectInfo instance];
        if (!instance.isForbidConfigBgColor) {
             instance.view.backgroundColor = [UIColor ly_vc_bgColor];
        }
        instance.statusBarStyle = UIStatusBarStyleLightContent;
        instance.navigationController.delegate = (id<UINavigationControllerDelegate>)instance;
    } error:nil];
}
@end
