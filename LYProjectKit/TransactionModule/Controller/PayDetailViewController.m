//
//  PayDetailViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/1.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "PayDetailViewController.h"

@interface PayDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *mineyLab;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UIButton *shensuBtn;
@property (weak, nonatomic) IBOutlet UIButton *fangbiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shensuABtn;

@end

@implementation PayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买单详情";
    if (self.model.status == 1) {
        self.stateLab.text = @"待支付";
        self.shensuABtn.hidden = YES;
        self.timeLab.text = [NSString stringWithFormat:@"%@%@%@",@"买家还有",@"",@"完成支付"];

    }
    else if (self.model.status == 2) {
        self.stateLab.text = @"已支付";
        self.shensuBtn.hidden = YES;
        self.fangbiBtn.hidden = YES;
        self.shensuABtn.hidden = NO;
        self.timeLab.text = @"待卖家确认放币";

    }
    else
    {
        self.stateLab.text = @"交易成功";
        self.shensuBtn.hidden = YES;
        self.fangbiBtn.hidden = YES;
        self.shensuABtn.hidden = NO;
        self.timeLab.text = @"卖家已放币";


    }
    self.priceLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.totalAmount,@"CNY"];
    self.accountLab.text = self.model.alipayAccount;
    self.nameLab.text = self.model.alipayName;
    self.numberLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.quantity,@"AGC"];
    self.mineyLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.unitPrice,@"CNY"];
    [self.codeImage sd_setImageWithURL:[NSURL URLWithString:self.model.alipayUrl]];
    self.orderId.text = self.model.orderNum;


}
- (IBAction)connectAction:(id)sender {
    [self pushViewControllerWithClassName:@"" params:nil];

}
- (IBAction)cancelAction:(id)sender {//取消交易
    
    
}
- (IBAction)payAction:(id)sender {//标记为已支付
    

}
- (IBAction)complaintAction:(id)sender {
    [self pushViewControllerWithClassName:@"" params:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
