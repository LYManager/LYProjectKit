//
//  KGDataCenter.m
//  KG
//
//  Created by 我是Waker同学 on 2019/3/20.
//  Copyright © 2019 walker. All rights reserved.
//

#import "KGDataCenter.h"
#import "PersistenceHelper.h"

NSString* const kAccessTokenKey         = @"kg_AccessToken";

NSString* const kAddressKey             = @"kg_Address";
NSString* const kInviteCodeKey          = @"kg_inviteCode";
NSString* const kableKey         = @"kg_able";
NSString* const knicknameKey         = @"kg_nickname";
NSString* const kmobileKey         = @"kg_mobile";
NSString* const kuserIdKey         = @"kg_userId";
NSString* const kimageKey         = @"kg_image";
NSString* const kemailKey         = @"kg_email";
NSString* const kIsSign  = @"isSign";
//NSString* const kHomePageKey  = @"kg_homePagePic";
NSString* const kusernameKey  = @"kg_usernameKey";

@implementation KGDataCenter
+ (instancetype)sharedCenter
{
    static KGDataCenter* center;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[KGDataCenter alloc] init];
    });
    return center;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _accessToken      = nil;
        
        _address          = nil;
        _inviteCode       = nil;
        _able             = nil;
        _nickname         = nil;
        _mobile           = nil;
        _userId           = nil;
        _image            = nil;
        _email            = nil;
        _isSign           = NO;
//        _homePagePic   = nil;
        _username         = nil;
    }
    return self;
}

- (void)saveData {
    if (self.accessToken) {
        [PersistenceHelper setData:self.accessToken forKey:kAccessTokenKey];
    }
    
    
    if (self.address) {
        [PersistenceHelper setData:self.address forKey:kAddressKey];
    }
    if (self.inviteCode) {
        [PersistenceHelper setData:self.inviteCode forKey:kInviteCodeKey];
    }
    if (self.able) {
        [PersistenceHelper setData:self.able forKey:kableKey];
    }
    if (self.nickname) {
        [PersistenceHelper setData:self.nickname forKey:knicknameKey];
    }
    if (self.username) {
        [PersistenceHelper setData:self.username forKey:kusernameKey];
    }
    
    if (self.mobile) {
        [PersistenceHelper setData:self.mobile forKey:kmobileKey];
    }
    if (self.userId) {
        [PersistenceHelper setData:self.userId forKey:kuserIdKey];
    }
    
    if (self.image) {
        [PersistenceHelper setData:self.image forKey:kimageKey];
    }
    
    if (self.email) {
        [PersistenceHelper setData:self.email forKey:kemailKey];
    }
    
//    if (self.homePagePic) {
//        [PersistenceHelper setData:self.homePagePic forKey:kHomePageKey];
//    }
    
    [PersistenceHelper setData:@(self.isSign) forKey:kIsSign];
}

- (void)loadData {
    self.accessToken  = [PersistenceHelper dataForKey:kAccessTokenKey];
    
    self.address  = [PersistenceHelper dataForKey:kAddressKey];
    self.inviteCode  = [PersistenceHelper dataForKey:kInviteCodeKey];
    self.able  = [PersistenceHelper dataForKey:kableKey];
    self.nickname  = [PersistenceHelper dataForKey:knicknameKey];
    self.username  = [PersistenceHelper dataForKey:kusernameKey];
    self.mobile  = [PersistenceHelper dataForKey:kmobileKey];
    self.userId  = [PersistenceHelper dataForKey:kuserIdKey];
    self.image = [PersistenceHelper dataForKey:kimageKey];
    self.email = [PersistenceHelper dataForKey:kemailKey];
    
    self.isSign = [[PersistenceHelper dataForKey:kIsSign] boolValue];
//    self.homePagePic = [PersistenceHelper dataForKey:kHomePageKey];
}

- (void)clearUserData {
    self.accessToken = nil;
    
    self.address    = nil;
    self.inviteCode = nil;
    self.able       = nil;
    self.nickname   = nil;
    self.username   = nil;
    self.mobile     = nil;
    self.userId     = nil;
    self.image      = nil;
    self.email      = nil;
//    self.homePagePic =nil;
    
    [PersistenceHelper removeForKey:kAccessTokenKey];
    
    [PersistenceHelper removeForKey:kAddressKey];
    [PersistenceHelper removeForKey:kInviteCodeKey];
    [PersistenceHelper removeForKey:kableKey];
    [PersistenceHelper removeForKey:knicknameKey];
    [PersistenceHelper removeForKey:kusernameKey];
    [PersistenceHelper removeForKey:kmobileKey];
    [PersistenceHelper removeForKey:kuserIdKey];
    [PersistenceHelper removeForKey:kimageKey];
    [PersistenceHelper removeForKey:kemailKey];
//    [PersistenceHelper removeForKey:kHomePageKey];
}

- (BOOL)checkAccessToken
{
    if (self.accessToken && self.accessToken.length>0) {
        return YES;
    } else {
        return NO;
    }
}

@end
