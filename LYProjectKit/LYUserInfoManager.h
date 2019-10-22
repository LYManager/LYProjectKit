// LYUserInfoManager.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>
#import "LYUserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYUserInfoManager : NSObject
/**< userInfo*/
@property(nonatomic,strong,nullable)LYUserInfo * userInfo;

+ (instancetype) shareInstance;
@end

NS_ASSUME_NONNULL_END
