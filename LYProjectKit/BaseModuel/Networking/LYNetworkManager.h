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
#define LYNetwork [LYNetworkManager sharedInstance]
@interface LYNetworkManager : NSObject
+ (instancetype) sharedInstance;

- (void)POSTWithApiPath:(NSString*)apiPath
          requestParams:(NSDictionary*)requestParams
                handler:(NetworkCompletionHandler)handler;
@end

NS_ASSUME_NONNULL_END
