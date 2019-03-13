// LYPageContext.h 
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

@interface LYPageContext : NSObject
+ (instancetype)shareInstance;



/**
 设置主控制器
 */
- (void)setupMainViewController;
@end

NS_ASSUME_NONNULL_END
