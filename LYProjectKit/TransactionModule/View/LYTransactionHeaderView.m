// LYTransactionHeaderView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTransactionHeaderView.h"

@interface LYTransactionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *qiuLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *zengFuLabel;

@end

@implementation LYTransactionHeaderView
- (void)configDataWithModel:(LYTradeModel *)model{
    self.qiuLabel.text = [NSString stringWithFormat:@"%.2f",model.data.sumAmount];
    self.todayNumLabel.text = [NSString stringWithFormat:@"%.2f",model.data.todayAmount];
    self.zengFuLabel.text = model.data.addPrice;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
