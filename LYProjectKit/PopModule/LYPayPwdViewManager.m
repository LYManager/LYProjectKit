// LYPayPwdViewManager.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/21. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYPayPwdViewManager.h"
#import "UIColor+Extention.h"
@implementation LYPayPwdViewManager
+ (SWOAuthCodeView *)p_getAuthCodeViewTarget:(id<SWOAuthCodeViewDelegate>)target beginEdit:(BOOL)isBeginEdit
{
    SWOAuthCodeView *oacView = [[SWOAuthCodeView alloc] initWithMaxLength:6];
    /* -----设置可选的属性 start----- */
    oacView.delegate = target; //设置代理
    oacView.boxNormalBorderColor = [UIColor clearColor]; //方框的边框正常状态时的边框颜色
    oacView.boxHighlightBorderColor = [UIColor ly_colorWithHexString:@"#4F97C7"]; //方框的边框输入状态时的边框颜色
    oacView.boxBorderWidth = 2; //方框的边框宽度
    oacView.boxCornerRadius = 6; //方框的圆角半径
    oacView.boxBGColor = [UIColor ly_colorWithHexString:@"#1F2348"];  //方框的背景色
    oacView.boxTextColor = [UIColor blackColor]; //方框内文字的颜色
    /* -----设置可选的属性 end----- */
    //显示键盘，可以输入验证码了
    if (isBeginEdit) {
        [oacView beginEdit];
    }
    return oacView;
}
@end
