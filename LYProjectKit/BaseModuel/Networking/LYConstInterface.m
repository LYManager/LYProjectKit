// LYConstInterface.m
// LYProjectKit
//
// Created by 赵良育 on 2019/10/20.
// Copyright © 2019 赵良育. All rights reserved.
//  接口

#import "LYConstInterface.h"


#if DEBUG
NSString * const BaseURL          = @"http://ant-api.cciasia.org";
#else
NSString * const BaseURL          = @"";
#endif
// 注册
NSString * const registerURL      = @"/ant-api/user/register";

// 获取验证码
NSString * const getMobileCodeURL = @"/ant-api/user/mobileCode";
