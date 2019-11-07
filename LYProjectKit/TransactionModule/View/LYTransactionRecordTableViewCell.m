// LYTransactionRecordTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/1. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTransactionRecordTableViewCell.h"
#import <OYCountDownManager.h>
#import "UIColor+Extention.h"


@interface LYTransactionRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UILabel *agcLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**< type*/
@property(nonatomic,assign)CellType type;
@end


@implementation LYTransactionRecordTableViewCell




- (void)awakeFromNib {
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
    NSLog(@"init ===== ");
    [self.payBtn ly_gradint];
    [self.cancelBtn ly_gradint];
    // Initialization code
}

- (void)configWithModel:(LYTradeRecordPageModel *)model{
    
         self.time =  model.createDate / 1000 - [[NSDate dateWithTimeIntervalSinceNow:0]timeIntervalSince1970];
        [self configStatusWithModel:model];
        self.rightLabel.text = model.tradeType == 1 ? @"出售" : @"购买";
           self.timeLabel.text = [self dateWithString:[@(model.createDate) stringValue] Format:@"yyyy-MM-dd HH:mm"];
           self.priceLabel.text = [NSString stringWithFormat:@"%.2f",model.unitPrice];
           self.agcLabel.text = [NSString stringWithFormat:@"%.2f",model.quantity];
           self.totalLabel.text = [NSString stringWithFormat:@"%.2f",model.totalAmount];
}

- (void) configStatusWithModel:(LYTradeRecordPageModel *)model{
    CellType type;
    if (model.tradeType == 1) {
        if (model.status == 1) {
            type = CellType_WaitMoney;
        }else if (model.status == 2){
            type = CellType_WaitSendAGC;
        }else{
            type = CellType_GetAGC;
        }
    }else{
        if (model.status == 1) {
            type = CellType_Waitpay;
        }else if (model.status == 2){
            type = CellType_Paied;
        }else{
            type = CellType_TradeSuccess;
        }
    }
    [self configUIWithStatus:type];
}

- (void)countDownNotification {
    /// 计算倒计时
     self.time --;
    if (self.type == CellType_Waitpay) {
        if (self.time <= 0) {
            self.statusDesLabel.text = @"交易已过期";
            return;
        }
        NSInteger m = self.time / 60;
        NSInteger s = self.time % 60;
        if (m >= 1) {
            self.statusDesLabel.text = [NSString stringWithFormat:@"您还有%ld分%ld秒完成支付",m,s];
        }else{
          self.statusDesLabel.text = [NSString stringWithFormat:@"您还有%ld秒完成支付",s];
        }
    }else if(self.type == CellType_WaitMoney){
        if (self.time <= 0) {
           self.statusDesLabel.text = @"交易已过期";
           return;
        }
        NSInteger m = self.time / 60;
       NSInteger s = self.time % 60;
       if (m > 1) {
           self.statusDesLabel.text = [NSString stringWithFormat:@"买家还有%ld分%ld秒完成交易",m,s];
       }else{
         self.statusDesLabel.text = [NSString stringWithFormat:@"买家还有%ld秒完成支付",s];
       }
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUIWithStatus:(CellType)type{
    self.type = type;
    NSString * status;
    NSString * statusDesc;
    NSString * payBtnTitle;
    UIColor * statusTextColor;
    BOOL hiddenCancelBtn;
    
    switch (type) {
        case CellType_Waitpay:
        {
            status = @"待付款";
            payBtnTitle = @"立即支付";
            statusTextColor = [UIColor ly_colorWithHexString:@"#D8575A"];
            hiddenCancelBtn = NO;
        }
        break;
        case CellType_Paied:
        {
           status = @"已支付";
            payBtnTitle = @"申诉";
            statusDesc = @"待卖家放币";
           statusTextColor = [UIColor ly_colorWithHexString:@"#CB9D2E"];
           hiddenCancelBtn = YES;
        }
        break;
        case CellType_TradeSuccess:
        {
            status = @"交易成功";
            payBtnTitle = @"申诉";
            statusDesc = @"卖家已放币";
            statusTextColor = [UIColor ly_colorWithHexString:@"#2DB249"];
            hiddenCancelBtn = YES;
        }
        break;
        case CellType_WaitMoney:
        {
           status = @"待收款";
          payBtnTitle = @"取消交易";
          statusTextColor = [UIColor ly_colorWithHexString:@"#D8575A"];
          hiddenCancelBtn = YES;
        }
        break;
        case CellType_WaitSendAGC:
        {
           status = @"已收款";
           payBtnTitle = @"申诉";
            statusDesc = @"待放币";
           statusTextColor = [UIColor ly_colorWithHexString:@"#CB9D2E"];
           hiddenCancelBtn = YES;
        }
        break;
        case CellType_GetAGC:
        {
          status = @"交易成功";
          payBtnTitle = @"申诉";
            statusDesc = @"买家已收币";
           statusTextColor = [UIColor ly_colorWithHexString:@"#2DB249"];
           hiddenCancelBtn = YES;
        }
        break;
    }
    self.cancelBtn.hidden = hiddenCancelBtn;
    [self.payBtn setTitle:payBtnTitle forState:UIControlStateNormal];
    self.statusLabel.textColor = statusTextColor;
    self.statusLabel.text = status;
    self.statusDesLabel.text = statusDesc;
}

//将时间戳转换为时间字符串
- (NSString*)dateWithString:(NSString*)str Format:(NSString*)format

{

    NSTimeInterval time = [str doubleValue]/1000;;

    /** [[NSDate date] timeIntervalSince1970]*1000;*/

    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象

    [dateFormatter setDateFormat:format];//设定时间格式,这里可以设置成自己需要的格式

    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];

    return currentDateStr;

}


@end
