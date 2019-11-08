//
//  PayStateViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/5.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "PayStateViewController.h"

@interface PayStateViewController ()
@property (weak, nonatomic) IBOutlet UILabel *payStateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIView *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIView *orderLab;
@property (weak, nonatomic) IBOutlet UIButton *shensuBtn;
@property (weak, nonatomic) IBOutlet UIButton *fangbiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shensuAbtn;
@property (weak, nonatomic) IBOutlet UILabel *accLab;
@property (weak, nonatomic) IBOutlet UILabel *ordLab;

@end

@implementation PayStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"卖单详情";
    
    [self.shensuBtn ly_gradint];
    [self.fangbiBtn ly_gradint];
    [self.shensuAbtn ly_gradint];
    
      if (self.model.status == 1) {
          self.payStateLab.text = @"买家待支付";
          self.shensuBtn.hidden = YES;
          self.fangbiBtn.hidden = YES;
          self.shensuAbtn.hidden = YES;
          
          NSString *timeStr = [NSString stringWithFormat:@"%ld",(long)self.model.remainTime];

          self.timeLab.text = [NSString stringWithFormat:@"%@%@%@",@"买家还有",[self ConvertStrToTime:timeStr],@"完成支付"];


      }
      else if (self.model.status == 2) {
          self.payStateLab.text = @"买家已支付";
          self.shensuAbtn.hidden = YES;
          self.timeLab.text = @"待放币";

      }
      else
      {
          self.payStateLab.text = @"交易成功";
          self.shensuBtn.hidden = YES;
          self.fangbiBtn.hidden = YES;
          self.shensuAbtn.hidden = NO;
          self.timeLab.text = @"已收款";


      }
    
    
    
    
    
    
      self.priceLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.totalAmount,@"CNY"];
      self.accLab.text = self.model.alipayAccount;
      self.nameLab.text = self.model.weichatAccount;
      self.numberLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.quantity,@"AGC"];
      self.priceLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.unitPrice,@"CNY"];
      self.ordLab.text = self.model.orderNum;



}
- (IBAction)connectAction:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.mobile]];

    UIWebView *webView = [[UIWebView alloc] init];

    [webView loadRequest:[NSURLRequest requestWithURL:url]];

    [self.view addSubview:webView];

}
- (IBAction)complaintAction:(id)sender {
        ContactCustomerViewController *custmVC = [[ContactCustomerViewController alloc]init];
    [self.navigationController pushViewController:custmVC animated:YES];


}
- (IBAction)putAction:(id)sender {//确认放币
    [self popConfirmControllerType:ConfirmType_FB backBlock:^{
        
        [LYNetwork POSTWithApiPath:concormlOutURL requestParams:@{
             @"tradeId":@(self.model.recordId)
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"确认放币" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];

             });
         }];
    }];

    
}
- (IBAction)connAction:(id)sender {
        ContactCustomerViewController *custmVC = [[ContactCustomerViewController alloc]init];
    [self.navigationController pushViewController:custmVC animated:YES];

}
- (NSString *)ConvertStrToTime:(NSString *)timeStr{

    

    long long time=[timeStr longLongValue];
    long second = time/1000%60;
    long m = time/1000/60;
    NSString *timeString =[NSString stringWithFormat:@"%02ld:%02ld",m,second];
    return timeString;

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
