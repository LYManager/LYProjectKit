// LYUserDefault.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYUserDefault.h"

#define CREATE_SETGET_UTILS_M(type,param,upperFirstParam) \
\
@synthesize param; \
- (void) set##upperFirstParam:(type)p##param{   \
param = p##param;               \
[[NSUserDefaults standardUserDefaults]setValue:param forKey:@#param];   \
[[NSUserDefaults standardUserDefaults]synchronize];\
}    \
\
- (type)param{  \
if(!param){   \
type saved =  [[NSUserDefaults standardUserDefaults]valueForKey:@#param];                                   \
if(saved){   \
param = saved;   \
}          \
}\
return param; \
}

@implementation LYUserDefault
+ (instancetype)shareInstance
{
    static LYUserDefault *userDefault = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDefault = [LYUserDefault new];
    });
    return userDefault;
}

CREATE_SETGET_UTILS_M(NSString *, test, Test)

@end
