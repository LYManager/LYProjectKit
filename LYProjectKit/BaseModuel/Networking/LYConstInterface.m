// LYConstInterface.m
// LYProjectKit
//
// Created by Sunshie on 2019/10/20.
// Copyright © 2019 Sunshie. All rights reserved.
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
// 登录
NSString * const loginURL         = @"/ant-api/user/login";

NSString * const homeURL          = @"/ant-api/ant/info";

NSString * const mineURL          = @"/ant-api/user/myInfo";

NSString * const antGonghuiURL    = @"/ant-api/ant/consortia";

NSString * const shengTaiURL      = @"/ant-api/ant/store";

NSString * const payTaskURL       = @"/ant-api/ant/buyTask";

NSString * const sendTaskCardURL = @"/ant-api/ant/giveCard";

NSString * const useCardURL = @"/ant-api/ant/useCard";

NSString * const idCardValiURL = @"/ant-api/IdVali/iDCardVali"; // 实名认证
