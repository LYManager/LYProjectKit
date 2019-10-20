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

- (IBAction)cardShopAction:(id)sender {
    [self configSelectedWithBtn:sender];
}

- (IBAction)workCardAction:(id)sender {
    [self configSelectedWithBtn:sender];
}

- (IBAction)pastTimeAction:(id)sender {
    [self configSelectedWithBtn:sender];
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
