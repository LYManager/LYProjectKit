// LYConstInterface.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/20. 
// Copyright © 2019 赵良育. All rights reserved. 
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