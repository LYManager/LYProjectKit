// LYMayiGongHuiHeaderView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYMayiGongHuiHeaderView.h"

@interface LYMayiGongHuiHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *realNameCardSendBtn;
@property (weak, nonatomic) IBOutlet UIButton *realNameCardUseBtn;
@property (weak, nonatomic) IBOutlet UIButton *mayiCardUseBtn;
@property (weak, nonatomic) IBOutlet UIButton *mayiCardSendBtn;

@property (weak, nonatomic) IBOutlet UILabel *realCardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *myyiCardNumberLabel;

@end

@implementation LYMayiGongHuiHeaderView




- (void) configUI {
    [self.realNameCardUseBtn ly_gradint];
    [self.realNameCardSendBtn ly_gradint];
    [self.mayiCardUseBtn ly_gradint];
    [self.mayiCardSendBtn ly_gradint];
}


- (IBAction)realCardUserBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(useCardWithType:)]) {
        [self.delegate useCardWithType:CardType_RealCard];
        
    }
}
- (IBAction)realCardSendBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendCaardWithType:)]) {
        [self.delegate sendCaardWithType:CardType_RealCard];
    }
}

- (IBAction)myyiCardUseBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(useCardWithType:)]) {
           [self.delegate useCardWithType:CardType_MayiCard];
       }
}
- (IBAction)mayiCardSendBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendCaardWithType:)]) {
        [self.delegate sendCaardWithType:CardType_MayiCard];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self configUI];
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self configUI];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
