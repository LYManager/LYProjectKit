// LYProgressHUD.m 
// CloudBuy 
// 
// Created by 赵良育 on 2018/11/29. 
// Copyright © 2018 赵良育. All rights reserved. 
// 

#import "LYProgressHUD.h"
#import "SVProgressHUD.h"
@implementation LYProgressHUD


+ (void)startDefaultConfig
{
    [SVProgressHUD appearance].offsetFromCenter = UIOffsetMake(0, 50);
//    [SVProgressHUD appearance].foregroundColor = LYMainColor;
    [SVProgressHUD appearance].defaultAnimationType = SVProgressHUDAnimationTypeNative;
}

+ (void)ly_showHUD
{
    [self ly_showHUDWithStatus:@""];
}
+ (void)ly_showHUDWithStatus:(NSString *)status
{
//    [SVProgressHUD setBackgroundColor:status.length ? LYRGBAColor(0, 0, 0, 0.9) : [UIColor clearColor]];
    [SVProgressHUD showWithStatus:status];
}
+ (void)ly_dismissHUD
{
   
    [SVProgressHUD dismiss];
}

+ (void)ly_showErrorWithMessageTip:(NSString *)messageTip
{
    [self ly_showErrorWithMessageTip:messageTip timeInterval:2];
}

+ (void)ly_showErrorWithMessageTip:(NSString *)messageTip timeInterval:(NSTimeInterval)timeInterval
{
//    [SVProgressHUD setBackgroundColor:LYRGBAColor(0, 0, 0, 0.9)];
    [SVProgressHUD setMinimumDismissTimeInterval:timeInterval];
    [SVProgressHUD showErrorWithStatus:messageTip];
}

+ (void)ly_showSuccessWithMessageTip:(NSString *)messageTip
{
    [self ly_showSuccessWithMessageTip:messageTip timeInterval:2];
}

+ (void)ly_showSuccessWithMessageTip:(NSString *)messageTip timeInterval:(NSTimeInterval)timeInterval
{
//    [SVProgressHUD setBackgroundColor:LYRGBAColor(0, 0, 0, 0.9)];
    [SVProgressHUD setMinimumDismissTimeInterval:timeInterval];
    [SVProgressHUD showSuccessWithStatus:messageTip];
}

@end
