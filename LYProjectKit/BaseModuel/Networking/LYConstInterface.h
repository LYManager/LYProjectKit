// LYConstInterface.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/20. 
// Copyright © 2019 Sunshie. All rights reserved. 
//  接口

#import <Foundation/Foundation.h>
// 网络响应键名定义
#define kResponseDataJSONKey_Code               @"code"
#define kResponseDataJSONKey_Mesg               @"message"
#define kResponseDataJSONKey_success            @"success"
#define kResponseDataJSONKey_Data               @"data"
#define kResponseDataJSONKey_DrivingData        @"driving_data"
#define kResponseDataJSONKey_SliderData         @"slider_data"
#define kResponseDataJSONKey_ComboData          @"combo_data"
#define kResponseDataJSONKey_CoachData          @"coach_data"
#define kResponseDataJSONKey_BxfcData           @"node_data"
#define kResponseDataJSONKey_LearnCarInfoData   @"learncar_info"
#define kResponseDataJSONKey_IndexAction_data   @"indexAction_data"


// 网络响应错误码定义
#define kResponseErrorCode_Unknown              NSIntegerMax
#define kResponseErrorCode_AccessTokenExpired   40001
#define kResponseErrorCode_AccessTokenInvalid   301
#define kResponseErrorCode_AccessTokenNull      3
#define kResponseErrorDomain                    @"kResponseErrorDomain"



UIKIT_EXTERN NSString * const BaseURL;

UIKIT_EXTERN NSString * const registerURL;

UIKIT_EXTERN NSString * const getMobileCodeURL;

UIKIT_EXTERN NSString * const loginURL;

UIKIT_EXTERN NSString * const homeURL;

UIKIT_EXTERN NSString * const rubbishURL;

UIKIT_EXTERN NSString * const mineURL;

UIKIT_EXTERN NSString * const confirmSendURL;

UIKIT_EXTERN NSString * const antGonghuiURL;

UIKIT_EXTERN NSString * const gonghuiRecordURL;

UIKIT_EXTERN NSString * const shengTaiURL;

UIKIT_EXTERN NSString * const teamURL;
UIKIT_EXTERN NSString * const billURL;
UIKIT_EXTERN NSString * const assetURL;
UIKIT_EXTERN NSString * const coinTypeURL;
UIKIT_EXTERN NSString * const coinWithdraw;
UIKIT_EXTERN NSString * const contactUrl;
UIKIT_EXTERN NSString * const resetNameUrl;
UIKIT_EXTERN NSString * const inviteUrl;
UIKIT_EXTERN NSString * const uploadImageUrl;

UIKIT_EXTERN NSString * const payTaskURL;

UIKIT_EXTERN NSString * const sendTaskCardURL;

UIKIT_EXTERN NSString * const useCardURL;

UIKIT_EXTERN NSString * const idCardValiURL;

UIKIT_EXTERN NSString * const sendCardURL;
UIKIT_EXTERN NSString * const resetLogURL;
UIKIT_EXTERN NSString * const sendCodeURL;
UIKIT_EXTERN NSString * const resetZhiURL;
UIKIT_EXTERN NSString * const registURL;

UIKIT_EXTERN NSString * const codelogURL;
UIKIT_EXTERN NSString * const forcedURL;
