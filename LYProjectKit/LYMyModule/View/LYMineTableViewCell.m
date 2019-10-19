// LYMineTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/18. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYMineTableViewCell.h"

@implementation LYMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configIcon:(NSString *)icon title:(NSString *)title{
    self.iconImageView.image = [UIImage imageNamed:icon];
    self.titleLable.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
