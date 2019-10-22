// LYShengTaiHeaderView.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYShengTaiHeaderView.h"

@interface LYShengTaiHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *earnLabel;
@property (weak, nonatomic) IBOutlet UILabel *huoyueLabel;

@end

@implementation LYShengTaiHeaderView
- (void)configDataWithEarn:(long)earn huoyue:(NSInteger)huoyue{
//    NSString *imageUrl = [LYUserInfoManager shareInstance].userInfo.actor;
//    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.earnLabel.text = [NSString stringWithFormat:@"%ld",earn];
    self.huoyueLabel.text = [@(huoyue) stringValue];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
