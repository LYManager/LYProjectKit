// LYUserDefault.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 
/**
    类描述
 */


#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

#define CREATE_SETGET_UTILS_H(type,strongOrWeak,name) \
\
@property (nonatomic,strongOrWeak) type name;
/// 存储到 - NSUserDefault -中，用属性去读取
@interface LYUserDefault : NSObject

+ (instancetype) shareInstance;
/* 测试存储 */
CREATE_SETGET_UTILS_H(NSString *, copy, test)
//o 用户信息dict
CREATE_SETGET_UTILS_H(NSDictionary *, strong, userInfoDict)

@end

//NS_ASSUME_NONNULL_END
