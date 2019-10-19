// LYMineHeaderView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/18. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYMineHeaderView.h"

@implementation LYMineHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnAction_AGC_Balance:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickAGCBalance)]) {
        [self.delegate clickAGCBalance];
    }
}

- (IBAction)myLevelAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickMyLevel)]) {
           [self.delegate clickMyLevel];
       }
}
- (IBAction)myTeamAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickMyTeam)]) {
           [self.delegate clickMyTeam];
       }
}
- (IBAction)myBillAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickMyBill)]) {
           [self.delegate clickMyBill];
       }
}
- (IBAction)inviteFriendAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickInviteFriend)]) {
           [self.delegate clickInviteFriend];
       }
}

@end
