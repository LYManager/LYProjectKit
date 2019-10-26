// LYMineHeaderView.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/18. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYMineHeaderView.h"

@interface LYMineHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *mayiGonghuiBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *agcCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *teamBtn;
@property (weak, nonatomic) IBOutlet UIButton *teamActionBtn;

@end

@implementation LYMineHeaderView
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.mayiGonghuiBtn ly_gradintLeftCircle];
}

- (void)configDataWithUserInfo:(LYUserInfo *)userInfo{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.actor]placeholderImage:[UIImage imageNamed:@"head_icon"]];
    self.nicknameLabel.text = userInfo.userName;
    self.agcCountLabel.text = [NSString stringWithFormat:@"%.2f",userInfo.agcAmount];
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@",userInfo.userId];
    self.levelLabel.text = userInfo.antLevel;
    [self.teamBtn setTitle:[NSString stringWithFormat:@"%@%@%@",@"我的团队",userInfo.groupAmount,@"人"] forState:UIControlStateNormal];
     [self.teamActionBtn setTitle:[NSString stringWithFormat:@"%@%@",@"团队活跃度:",userInfo.groupAmount] forState:UIControlStateNormal];
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

- (void)layoutSubviews{
    [super layoutSubviews];
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.height/2;
    self.headImageView.clipsToBounds = YES;
}

@end
