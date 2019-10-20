// LYNetworkManager.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/20. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <Foundation/Foundation.h>
#import "LYConstInterface.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^NetworkCompletionHandler)(NSDictionary *response, NSError* _Nullable error);
#define LYNetwork [LYNetworkManager sharedInstance]
@interface LYNetworkManager : NSObject
+ (instancetype) sharedInstance;

- (void)POSTWithApiPath:(NSString*)apiPath
          requestParams:(NSDictionary*)requestParams
                handler:(NetworkCompletionHandler)handler;
@end

NS_ASSUME_NONNULL_END
