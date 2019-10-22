// LYMayiGongHuiFooterView.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYMayiGongHuiFooterView.h"
#import "LYAntGonghuiData.h"
@interface LYMayiGongHuiFooterView ()
@property (weak, nonatomic) IBOutlet UIImageView *tomImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@end

@implementation LYMayiGongHuiFooterView
- (void)configDataWithModel:(LYAntGonghuiDataModel *)model{
    [self.tomImageView sd_setImageWithURL:[NSURL URLWithString:model.upgradeRules]];
    [self.bottomImageView sd_setImageWithURL:[NSURL URLWithString:model.bonusScheeme]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
