// LYTransactionSaleTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTransactionSaleTableViewCell.h"

@interface LYTransactionSaleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;

@end

@implementation LYTransactionSaleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.saleBtn ly_gradint];
    // Initialization code
}

- (IBAction)saleBtnAction:(UIButton *)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
