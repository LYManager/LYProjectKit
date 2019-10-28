// LYAVOSCloudManager.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/28. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAVOSCloudManager : NSObject
+ (instancetype) shareInstance;

- (void) registerCloud;

@end

NS_ASSUME_NONNULL_END
