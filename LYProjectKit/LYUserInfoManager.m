// LYUserInfoManager.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/21. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYUserInfoManager.h"

@implementation LYUserInfoManager
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static LYUserInfoManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[LYUserInfoManager alloc]init];
    });
    return manager;
}
@end
