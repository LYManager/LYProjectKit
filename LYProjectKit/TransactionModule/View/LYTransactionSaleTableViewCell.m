// LYTransactionSaleTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTransactionSaleTableViewCell.h"

@interface LYTransactionSaleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLabel;
/**< <#des#>*/
@property(nonatomic,strong)LYTradePageModel * model;
@end

@implementation LYTransactionSaleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.saleBtn ly_gradint];
    // Initialization code
}

- (void)configDataWithModel:(LYTradePageModel *)model{
    self.model = model;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.actor] placeholderImage:nil];
    self.nicknameLabel.text = model.nickName;
    self.phoneLabel.text = model.mobile;
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f",model.totalAmount];
    self.danjiaLabel.text = [NSString stringWithFormat:@"单价：%.2fCNY",model.unitPrice];
    self.totalNumLabel.text = [NSString stringWithFormat:@"买单总数：%.2f",model.quantity];
}

- (void)configBtnEnable:(BOOL)enable{
    self.saleBtn.enabled = enable;
    [self.saleBtn setTitle:enable ? @"下架" : @"出售" forState:UIControlStateNormal];
}

- (IBAction)saleBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(unSaleAction:)]) {
        [self.delegate unSaleAction:self.model];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
