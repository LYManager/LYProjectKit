// LYUserInfo.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUserInfo : NSObject
/**< 头像*/
@property(nonatomic,copy)NSString * actor;
/**< 邀请码*/
@property(nonatomic,copy)NSString *  inviteCode;
/**< 电话*/
@property(nonatomic,copy)NSString *  mobile;
/**< 昵称*/
@property(nonatomic,copy)NSString * nickname;
/**< username*/
@property(nonatomic,copy)NSString *  userName;
/**< token*/
@property(nonatomic,copy)NSString *  token;
/**< userID*/
@property(nonatomic,copy)NSString *  userId;
/**< 等级*/
@property(nonatomic,copy)NSString *  antLevel;
/**< 实名卡数量*/
@property(nonatomic,assign)NSInteger cardNums;
/**< agc数量*/
@property(nonatomic,assign)CGFloat agcAmount;
@end

NS_ASSUME_NONNULL_END
