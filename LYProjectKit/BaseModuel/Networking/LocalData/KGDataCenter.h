//
//  KGDataCenter.h
//  KG
//
//  Created by 我是Waker同学 on 2019/3/20.
//  Copyright © 2019 walker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DATACENTER [KGDataCenter sharedCenter]
@interface KGDataCenter : NSObject
+ (instancetype)sharedCenter;

- (void)saveData;
- (void)loadData;

- (void)clearUserData;

- (BOOL)checkAccessToken;

// 登录token
@property (nonatomic, copy) NSString *accessToken;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *inviteCode;
@property (nonatomic, copy) NSString *able;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *email;
//@property (nonatomic, strong) NSData *homePagePic;
@property (nonatomic, assign) BOOL isSign;
@end
