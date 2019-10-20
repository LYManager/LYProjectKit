// LYShengTaiSessionHeaderView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYShengTaiSessionHeaderView.h"

@interface LYShengTaiSessionHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *cardShopBtn;
@property (weak, nonatomic) IBOutlet UIButton *workCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *pastTimeCardBtn;

@end

@implementation LYShengTaiSessionHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
//    默认
    self.cardShopBtn.selected = YES;
}

- (IBAction)cardShopAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self configSelectedWithBtn:sender];

    if ([self.delegate respondsToSelector:@selector(selectCardType:)]) {
        [self.delegate selectCardType:LYShengTaiShopCardType_ShopCard];
    }
}

- (IBAction)workCardAction:(UIButton *)sender {
    if (sender.selected) {
           return;
       }
    [self configSelectedWithBtn:sender];
      
    if ([self.delegate respondsToSelector:@selector(selectCardType:)]) {
           [self.delegate selectCardType:LYShengTaiShopCardType_TaskCard];
       }
}

- (IBAction)pastTimeAction:(UIButton *)sender {
    if (sender.selected) {
           return;
       }
    [self configSelectedWithBtn:sender];
    if ([self.delegate respondsToSelector:@selector(selectCardType:)]) {
           [self.delegate selectCardType:LYShengTaiShopCardType_PastCard];
    }
}


- (void) configSelectedWithBtn:(UIButton *)sender{
    self.cardShopBtn.selected = sender == self.cardShopBtn;
    self.workCardBtn.selected = sender == self.workCardBtn;
    self.pastTimeCardBtn.selected = sender == self.pastTimeCardBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
