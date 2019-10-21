// LYShengTaiShopCardCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYShengTaiShopCardCell.h"

@interface LYShengTaiShopCardCell ()
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *reduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;

@end

@implementation LYShengTaiShopCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configUI];
    // Initialization code
}

- (void)configData:(id)data type:(LYShengTaiShopCardType)cardType{
    [self hidenBuyBtn:cardType != LYShengTaiShopCardType_ShopCard];
   
}

- (void) hidenBuyBtn:(BOOL)hiden{
    self.buyBtn.hidden = hiden;
    self.reduceLabel.font = [UIFont systemFontOfSize:hiden ? 12 : 16];
}

- (void) configUI {
    [self.buyBtn ly_gradint];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
