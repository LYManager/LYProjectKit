// LYShengTaiBaseTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/20. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYShengTaiBaseTableViewCell.h"

@implementation LYShengTaiBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
  
    // Initialization code
}

- (void) configUI{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(10, 10, 30, 30);
    [self.contentView addSubview:view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
