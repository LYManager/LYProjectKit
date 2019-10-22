// LYShengTaiShopCardCell.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYShengTaiShopCardCell.h"
#import "LYTaskCardModel.h"
@interface LYShengTaiShopCardCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cardIconImageView;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *reduceDesLabel;

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

- (void)configData:(LYTaskCardModel *)data type:(LYShengTaiShopCardType)cardType{
    [self hidenBuyBtn:cardType != LYShengTaiShopCardType_ShopCard];
    [self.cardIconImageView sd_setImageWithURL:[NSURL URLWithString:data.taskUrl]];
    switch (cardType) {
        case LYShengTaiShopCardType_ShopCard:
            {
                self.leftTopLabel.text = [NSString stringWithFormat:@"周期:%ld天",data.cycleDays];
                self.leftBottomLabel.text = [NSString stringWithFormat:@"总奖励:%.1ld",data.totalEarning];
                self.reduceLabel.text = [NSString stringWithFormat:@"%ldAGC",data.amount];
            }
            break;
        case LYShengTaiShopCardType_TaskCard:
           {
               self.leftTopLabel.text = [NSString stringWithFormat:@"购买时间:%@",data.createTime];
               self.leftBottomLabel.text = [NSString stringWithFormat:@"剩余天数:%ld天",data.remainDays];
               self.reduceLabel.text = [NSString stringWithFormat:@"%ldAGC",data.nowEarning];
           }
           break;
        case LYShengTaiShopCardType_PastCard:
           {
                self.leftTopLabel.text = [NSString stringWithFormat:@"购买时间:%@",data.createTime];
                self.leftBottomLabel.text = [NSString stringWithFormat:@"过期时间:%@",data.endTime];
                self.reduceLabel.text = [NSString stringWithFormat:@"%ldAGC",data.nowEarning];
           }
           break;
        
    }
}

- (void) hidenBuyBtn:(BOOL)hiden{
    self.buyBtn.hidden = hiden;
    self.reduceDesLabel.text = hiden ? @"已产生收益" : @"消耗";
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
