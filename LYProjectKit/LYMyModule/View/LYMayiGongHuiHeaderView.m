// LYMayiGongHuiHeaderView.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYMayiGongHuiHeaderView.h"
#import "LYAntGonghuiData.h"
#import "UIColor+Extention.h"
@interface LYMayiGongHuiHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *realNameCardSendBtn;
@property (weak, nonatomic) IBOutlet UIButton *realNameCardUseBtn;
@property (weak, nonatomic) IBOutlet UIButton *mayiCardUseBtn;
@property (weak, nonatomic) IBOutlet UIButton *mayiCardSendBtn;

@property (weak, nonatomic) IBOutlet UILabel *realCardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *myyiCardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhituiNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *huoyueLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (weak, nonatomic) IBOutlet UILabel *realCheckCardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *antGonghuiCardNameLabel;
@end

@implementation LYMayiGongHuiHeaderView


- (void)configDataWithModel:(LYAntGonghuiDataModel *)model{
//    model.isUseLaborCard = YES;
    self.levelLabel.text = model.levelName;
    self.zhituiNumLabel.text = [@(model.childNums)stringValue];
    self.huoyueLabel.text = [@(model.liveness) stringValue];
    [self configCardWithModel:model.propsCardList.firstObject];
    [self configCardWithModel:model.propsCardList.lastObject];
    [self configBtn:self.realNameCardUseBtn isUsed:model.isUseNameCard];
    [self configBtn:self.mayiCardUseBtn isUsed:model.isUseLaborCard];
}

- (void) configBtn:(UIButton *)button isUsed:(BOOL)isUsed{
    [button setTitle:isUsed ? @"已激活" : @"立即激活" forState:UIControlStateNormal];
    if (isUsed) {
         [button setBackgroundColor:[UIColor ly_colorWithHexString:@"#313656"]];
        button.layer.cornerRadius = button.frame.size.height / 2;
    }else{
        [button ly_gradint];
    }
    button.enabled = !isUsed;
}



- (void) configCardWithModel:(LYAntCardModel *)cardModel{
    if (cardModel.cardId == 1) {
        self.realCheckCardNameLabel.text = cardModel.cardName;
        self.realCardNumberLabel.text = [NSString stringWithFormat:@"拥有%ld张",cardModel.cardCount];
    }else{
        self.antGonghuiCardNameLabel.text =cardModel.cardName;
         self.myyiCardNumberLabel.text = [NSString stringWithFormat:@"拥有%ld张",cardModel.cardCount];
    }
}

- (void) configUI {
//    [self.realNameCardUseBtn ly_gradint];
    [self.realNameCardSendBtn ly_gradint];
//    [self.mayiCardUseBtn ly_gradint];
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
- (IBAction)contackKefu:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerContackKefu)]) {
        [self.delegate headerContackKefu];
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
