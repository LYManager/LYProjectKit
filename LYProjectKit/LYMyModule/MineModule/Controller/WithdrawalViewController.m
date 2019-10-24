//
//  WithdrawalViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "WithdrawalViewController.h"

@interface WithdrawalViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *coinLab;
@property (weak, nonatomic) IBOutlet UILabel *rmbLab;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UITextField *pwText;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"提现";
    self.nameLab.text = self.assModel.name;
    self.coinLab.text = self.assModel.agcAmount;
    self.rmbLab.text =[NSString stringWithFormat:@"%@%@%@",@"≈",self.assModel.agcToRmb,@"CNY"];
   

    self.addressText.attributedPlaceholder = [[self.addressText placeholder] ly_attributePlaceholder];
    self.numberText.attributedPlaceholder = [[self.numberText placeholder] ly_attributePlaceholder];
    self.pwText.attributedPlaceholder = [[self.pwText placeholder] ly_attributePlaceholder];

    [self.submitBtn ly_gradint];
    
    self.detailLab.numberOfLines = 0;
    NSString *strUrl = [self.wicon stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    self.detailLab.text = strUrl;

}
- (IBAction)submitBtnAction:(id)sender {
    
    
    
    [LYNetwork POSTWithApiPath:coinWithdraw requestParams:@{
             @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",@"withdrawDTO":@{@"address":self.assModel.userAddress,@"coinType":self.assModel.coinType,@"amount":self.numberText.text,@"transPassword":self.pwText.text},
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        NSLog(@"成功");
    }];
    
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
