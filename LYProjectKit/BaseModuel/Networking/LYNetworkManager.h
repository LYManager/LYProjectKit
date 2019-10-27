// LYNetworkManager.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/20. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>
#import "LYConstInterface.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^NetworkCompletionHandler)(NSDictionary  *_Nullable response, NSError* _Nullable error);
// 自己处理错误 和 正确
typedef void(^NetworkCompletionSuccess) (NSDictionary *_Nullable response);
typedef void(^NetworkCompletionFail) (NSError *_Nullable error);
#define LYNetwork [LYNetworkManager sharedInstance]
@interface LYNetworkManager : NSObject
+ (instancetype) sharedInstance;

- (void)POSTWithApiPath:(NSString*)apiPath
          requestParams:(NSDictionary*)requestParams
                handler:(NetworkCompletionHandler)handler;

- (void) POSTWithApiPath:(NSString *)apiPath
           requestParams:(NSDictionary *)requestParams
        shouldHandlerError:(NetworkCompletionHandler)handler;

- (void) uploadIcon:(NSString *)url param:(NSDictionary *)requestParams;
@end

NS_ASSUME_NONNULL_END
