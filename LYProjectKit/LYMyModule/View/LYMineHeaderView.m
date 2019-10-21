// LYMineHeaderView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/18. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYMineHeaderView.h"

@interface LYMineHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *mayiGonghuiBtn;

@end

@implementation LYMineHeaderView
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.mayiGonghuiBtn ly_gradintLeftCircle];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)mayigonghuiAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickMayiGonghui)]) {
        [self.delegate clickMayiGonghui];
    }
}



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
