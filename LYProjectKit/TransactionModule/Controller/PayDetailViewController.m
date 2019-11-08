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
@property (weak, nonatomic) IBOutlet UILabel *zhifuAccLab;
@property (weak, nonatomic) IBOutlet UILabel *shoukuanLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

@end

@implementation PayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买单详情";
    
    [self.shensuBtn ly_gradint];
    [self.fangbiBtn ly_gradint];
    [self.shensuABtn ly_gradint];
    if (self.model.status == 1) {
        self.stateLab.text = @"待支付";
        self.shensuABtn.hidden = YES;
        NSString *timeStr = [NSString stringWithFormat:@"%ld",(long)self.model.remainTime];

        self.timeLab.text = [NSString stringWithFormat:@"%@%@%@",@"买家还有",[self ConvertStrToTime:timeStr],@"完成支付"];
        
        

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
    if (self.model.payType == 1) {//微信
        
        self.zhifuAccLab.text = @"支付宝账号";
        self.shoukuanLab.text = @"收款人昵称";
        self.codeLab.text = @"支付宝收款码";
        self.accountLab.text = self.model.alipayAccount;
        self.nameLab.text = self.model.alipayName;
        [self.codeImage sd_setImageWithURL:[NSURL URLWithString:self.model.alipayUrl]];

    }
    else
    {
        self.zhifuAccLab.text = @"微信账号";
        self.shoukuanLab.text = @"收款人昵称";
        self.codeLab.text = @"微信收款码";
        self.accountLab.text = self.model.weichatAccount;
        self.nameLab.text = self.model.weiChatName;
        [self.codeImage sd_setImageWithURL:[NSURL URLWithString:self.model.weichatUrl]];
    }
    
    
    
    self.priceLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.totalAmount,@"CNY"];
    self.numberLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.quantity,@"AGC"];
    self.mineyLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.unitPrice,@"CNY"];
    self.orderId.text = self.model.orderNum;


}
- (NSString *)ConvertStrToTime:(NSString *)timeStr{

    

    long long time=[timeStr longLongValue];
    long second = time/1000%60;
 long m = time/1000/60;
    NSString *timeString =[NSString stringWithFormat:@"%02ld:%02ld",m,second];
    return timeString;

}


- (IBAction)connectAction:(id)sender {
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.mobile]];

       UIWebView *webView = [[UIWebView alloc] init];

       [webView loadRequest:[NSURLRequest requestWithURL:url]];

       [self.view addSubview:webView];

}
- (IBAction)cancelAction:(id)sender {//取消交易
    
    [self popConfirmControllerType:ConfirmType_CancelTrade backBlock:^{
        
        [LYNetwork POSTWithApiPath:cancelOutURL requestParams:@{
             @"tradeId":@(self.model.recordId)
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"取消交易" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];

             });
         }];
    }];
    
    
}
- (IBAction)payAction:(id)sender {//标记为已支付
    
    [self popConfirmControllerType:ConfirmType_Purchased backBlock:^{
        
        [LYNetwork POSTWithApiPath:concormlOutURL requestParams:@{
             @"tradeId":@(self.model.recordId)
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"标记为已支付" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];

             });
         }];
    }];
}
- (IBAction)complaintAction:(id)sender {
    ContactCustomerViewController *custmVC = [[ContactCustomerViewController alloc]init];
    [self.navigationController pushViewController:custmVC animated:YES];

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
