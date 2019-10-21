// LYNetworkManager.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/20. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
// api
#import "LYConstInterface.h"
// data
#import "KGDataCenter.h"

#import "NSString+Extension.h"
#import "GHLLocalizable.h"
#import "NSDictionary+TypeSafe.h"

#import "AppDelegate.h"
#import "LYResponseCode.h"
#import "LYPageContext.h"
#define kAppDelegate                       ((AppDelegate *)[[UIApplication sharedApplication] delegate])

static NSString * const kErrorUserInfoMsgKey =  @"errorMsg"; // 错误key
@interface LYNetworkManager ()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation LYNetworkManager
+ (instancetype)sharedInstance{
    static LYNetworkManager *_center = nil;
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           _center = [[LYNetworkManager alloc] init];
           [_center setup];
       });
       return _center;
}

- (void) setup{
    if (![[AFNetworkActivityIndicatorManager sharedManager] isEnabled]) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    // 设置证书模式
    self.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    self.manager.securityPolicy.allowInvalidCertificates = YES;// 是否信任非法证书
    [self.manager.securityPolicy setValidatesDomainName:NO];// 是否在证书域字段中验证域名*/
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil ,nil]];
}

- (void)POSTWithApiPath:(NSString*)apiPath
                 requestParams:(NSDictionary*)requestParams
                       handler:(NetworkCompletionHandler)handler
{
     [LYProgressHUD ly_showHUD];
    NSMutableDictionary * paramsNew = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    
    if (DATACENTER.accessToken) {
        [paramsNew setValue:DATACENTER.accessToken forKey:@"token"];
    }
    
    if (DATACENTER.userId) {
        [paramsNew setValue:DATACENTER.userId forKey:@"userId"];
    }
    NSLog(@"%@",paramsNew);
    NSString * lanuageStr = [GHLLocalizable userLanguage];
    
    NSString * paramsNewStr = [self convertToJsonData:paramsNew];
    
    paramsNewStr = [paramsNewStr aes256_encrypt:@"WFsbHB3btdogsios"];
    
    int dataInt =  [[NSDate date] timeIntervalSince1970];
    
    NSString * str =[NSString stringWithFormat:@"O%i",dataInt];
    
    
    [self.manager POST:apiPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *paramsData =[paramsNewStr dataUsingEncoding:NSUTF8StringEncoding];
        NSData *dateStr =[str dataUsingEncoding:NSUTF8StringEncoding];
        
        [formData appendPartWithFormData:paramsData name:@"data"];
        [formData appendPartWithFormData:dateStr name:@"source"];
        if ([lanuageStr isEqualToString:@"ko"]) {
            NSData *lanStr =[@"ko_kr" dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:lanStr name:@"language"];
        }else{
            NSData *lanStr =[@"" dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:lanStr name:@"language"];
        }
        NSLog(@"%@",formData);
        [LYProgressHUD ly_dismissHUD];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if ([responseObject[@"code"] integerValue] == ResponseCodePasteLogin) {
        //            清除用户信息
            [LYUserDefault shareInstance].userInfoDict = nil;
            [LYUserInfoManager shareInstance].userInfo = nil;
            [[LYPageContext shareInstance]setupLoginViewController];
         }else{
             !handler ?: handler(responseObject,nil);
         }
         [LYProgressHUD ly_dismissHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         !handler ?: handler(nil,error);
        [[UIApplication sharedApplication].keyWindow makeToast:[NSString stringWithFormat:@"错误码：%ld",error.code] duration:2 position:CSToastPositionCenter];
         [LYProgressHUD ly_dismissHUD];
       
    }];
}
#pragma mark🐒------处理请求数据------🐒
- (void)_handleGenerallResponse:(id)response
          withCompletionHandler:(NetworkCompletionHandler)handler
{
    NSString *bSuccCode = [response kgstringForKey:kResponseDataJSONKey_Code];
    
    if ([bSuccCode isEqualToString:@"0"]) {
        // 返回json中code是1
        if (handler) {
            id data = [response objectForKey:kResponseDataJSONKey_Data];
            if (data && [data isKindOfClass:[NSDictionary class]]) {
                handler(data, nil);
            } else {
                handler(response, nil);
            }
        }
    } else {
        if (([bSuccCode isEqualToString:@"104"]) || ([bSuccCode isEqualToString:@"999"])) {
            [DATACENTER clearUserData];
            [DATACENTER saveData];
            [kAppDelegate showLogin];
        }
        NSInteger code = [self _responseErrorCode:response];
        [self _processErrorWithCode:code response:response handler:handler];
    }
}

- (NSUInteger)_responseErrorCode:(id)response
{
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSUInteger code = [response objectForKey:kResponseDataJSONKey_Code] ? [response kgintegerForKey:kResponseDataJSONKey_Code] : kResponseErrorCode_Unknown;
        return code;
    }
    return kResponseErrorCode_Unknown;
}

- (void)_processErrorWithCode:(NSInteger)code
                     response:(id)response
                      handler:(NetworkCompletionHandler)handler
{
    if (handler) {
        NSError* error = [NSError errorWithDomain:kResponseErrorDomain
                                             code:code
                                         userInfo:@{kErrorUserInfoMsgKey:[response objectForKey:kResponseDataJSONKey_Mesg]}];
        
        handler(response, error);
    }
}

#pragma mark🐒------处理用户登录后------🐒
- (void)_handleUserVerLoginResponse:(id)response
           withCompletionHandler:(NetworkCompletionHandler)handler {
    NSInteger code = [response kgintegerForKey:kResponseDataJSONKey_Code];
    
    if (code == 0) {
        
        DATACENTER.accessToken = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"token"];
        DATACENTER.address = [[response kgdictionaryForKey:@"kResponseDataJSONKey_Data"] kgstringForKey:@"ethaddress"];
//        DATACENTER.address = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"address"];
        DATACENTER.inviteCode = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"inviteCode"];
        DATACENTER.able = [[response kgdictionaryForKey:kResponseDataJSONKey_Data]  kgstringForKey:@"able"];
        DATACENTER.nickname = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"nickname"];
        DATACENTER.mobile =  [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"mobile"];
        DATACENTER.userId = [[response kgdictionaryForKey:kResponseDataJSONKey_Data]  kgstringForKey:@"userId"];
        DATACENTER.image = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"image"];
        DATACENTER.email = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"email"];
        
        //
        //        NSString* urlText = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"head_img"];
        //        urlText = [urlText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //        DATACENTER.userAvatar = urlText;
        //        DATACENTER.userPhone = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"phone"];
        //
        //        //3.7.5 新增
        //        DATACENTER.realname = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"realname"];
        //        DATACENTER.idCard_number = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgstringForKey:@"identity"];
        //
        //        //4.2.3新增
        //        DATACENTER.is_member = [[response kgdictionaryForKey:kResponseDataJSONKey_Data] kgboolForKey:@"is_member"];
        //
        [DATACENTER saveData];
        
        // 重埋cookie
        //        [kAppDelegate setWebViewCookie];
        
        if (handler) {
            handler(response, nil);
        }
    } else {
        NSInteger code = [self _responseErrorCode:response];
        [self _processErrorWithCode:code response:response handler:handler];
    }
}



-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


@end
