// LYTransactionSessionHeaderView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTransactionSessionHeaderView.h"

@interface LYTransactionSessionHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *transactionBtn;
@end

@implementation LYTransactionSessionHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.saleBtn.selected = YES;
}

- (IBAction)saleBtnAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self configSelectedWithBtn:sender];

}

- (IBAction)buyBtnAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self configSelectedWithBtn:sender];

}

- (IBAction)transactionBtnAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self configSelectedWithBtn:sender];

}


- (void) configSelectedWithBtn:(UIButton *)sender{
    self.saleBtn.selected = sender == self.saleBtn;
    self.buyBtn.selected = sender == self.buyBtn;
    self.transactionBtn.selected = sender == self.transactionBtn;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
