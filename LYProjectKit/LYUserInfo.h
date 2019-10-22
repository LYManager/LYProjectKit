// LYUserInfo.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/21. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUserInfo : NSObject
/**< 邀请码*/
@property(nonatomic,copy)NSString *  inviteCode;
/**< 电话*/
@property(nonatomic,copy)NSString *  mobile;
/**< 昵称*/
@property(nonatomic,copy)NSString * nickname;
/**< token*/
@property(nonatomic,copy)NSString *  token;
/**< userID*/
@property(nonatomic,copy)NSString *  userId;
@end

NS_ASSUME_NONNULL_END
