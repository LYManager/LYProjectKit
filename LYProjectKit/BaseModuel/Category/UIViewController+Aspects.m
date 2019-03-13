// UIViewController+Aspects.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "UIViewController+Aspects.h"
#import <Aspects.h>
@implementation UIViewController (Aspects)

+ (void)load
{
    [NSClassFromString(@"LYBaseViewController") aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>acpectInfo){
         UIViewController * instance = [acpectInfo instance];
        instance.view.backgroundColor = [UIColor whiteColor];
        instance.navigationController.delegate = (id<UINavigationControllerDelegate>)instance;
    } error:nil];
}
@end
