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
NSString * const BaseURL          = @"http://ant-api.cciasia.org";
#endif
//NSString * const BaseURL          = @"http://api.agc.tw";
// 注册
NSString * const registerURL      = @"/ant-api/user/register";

// 获取验证码
NSString * const getMobileCodeURL = @"/ant-api/user/mobileCode";
// 登录
NSString * const loginURL         = @"/ant-api/user/login";

NSString * const homeURL          = @"/ant-api/ant/info";

NSString * const rubbishURL =   @"/ant-api/ant/classify";

NSString * const mineURL          = @"/ant-api/user/myInfo";

NSString * const antGonghuiURL    = @"/ant-api/ant/consortia";

NSString * const shengTaiURL = @"/ant-api/ant/store";
//团队
NSString * const teamURL = @"/ant-api/user/myTeamInfo";
//账单
NSString * const billURL = @"/ant-api/user/myNewBill";
//钱包
NSString * const assetURL = @"/ant-api/asset/myAsset";
//币种明细
NSString * const coinTypeURL = @"/ant-api/asset/coinInfo";
//币种tixin
NSString * const coinWithdraw = @"/ant-api/asset/withdraw";
//客服
NSString * const contactUrl = @"/ant-api/user/customerService";
//修改昵称
NSString * const resetNameUrl = @"/ant-api/user/modifyName";
//邀请好友
NSString * const inviteUrl = @"/ant-api/user/inviteView";
//图片上传
NSString * const uploadImageUrl = @"/ant-api//user/uploadIcon";

//NSString * const shengTaiURL      = @"/ant-api/ant/store";

NSString * const payTaskURL       = @"/ant-api/ant/buyTask";

NSString * const sendTaskCardURL = @"/ant-api/ant/giveCard";

NSString * const useCardURL = @"/ant-api/ant/useCard";

NSString * const idCardValiURL = @"/ant-api/IdVali/iDCardVali"; // 实名认证

NSString * const sendCardURL = @"/ant-api/ant/giveCard";

NSString * const resetLogURL = @"/ant-api/user/changeLoginPassword";

NSString * const sendCodeURL = @"/ant-api/user/mobileCode";

NSString * const resetZhiURL = @"/ant-api/user/changePayPassword";

NSString * const registURL = @"/ant-api/user/register";

NSString * const codelogURL = @"/ant-api/user/mobileLogin";

NSString * const forcedURL = @"/ant-api/common/appClient";

