// LYUserInfoManager.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
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
