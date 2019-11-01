// LYTransactionRecordTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/1. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTransactionRecordTableViewCell.h"

@interface LYTransactionRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@end


@implementation LYTransactionRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.payBtn ly_gradint];
    [self.cancelBtn ly_gradint];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
