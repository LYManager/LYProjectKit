// LYMineHeaderView.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/18. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LYMineHeaderViewDelegate <NSObject>

- (void) clickMayiGonghui;

- (void) clickAGCBalance;

- (void) clickMyLevel;

-(void) clickMyTeam;

- (void) clickMyBill;

- (void) clickInviteFriend;

@end
@interface LYMineHeaderView : UIView
/**< <#des#>*/
@property(nonatomic,weak)id<LYMineHeaderViewDelegate> delegate;

- (void) configDataWithUserInfo:(LYUserInfo *)userInfo;
@end

NS_ASSUME_NONNULL_END
