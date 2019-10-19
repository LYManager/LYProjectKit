// LYMineHeaderView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/18. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LYMineHeaderViewDelegate <NSObject>

- (void) clickAGCBalance;

- (void) clickMyLevel;

-(void) clickMyTeam;

- (void) clickMyBill;

- (void) clickInviteFriend;

@end
@interface LYMineHeaderView : UIView
/**< <#des#>*/
@property(nonatomic,weak)id<LYMineHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
