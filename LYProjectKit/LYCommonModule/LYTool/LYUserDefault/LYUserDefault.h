// LYUserDefault.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
/**
    类描述
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define CREATE_SETGET_UTILS_H(type,strongOrWeak,name) \
\
@property (nonatomic,strongOrWeak) type name;
/// 存储到 - NSUserDefault -中，用属性去读取
@interface LYUserDefault : NSObject

+ (instancetype) shareInstance;
/* 测试存储 */
CREATE_SETGET_UTILS_H(NSString *, copy, test)

@end

NS_ASSUME_NONNULL_END
