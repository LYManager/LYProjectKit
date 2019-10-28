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
    
    
    if (_addressText.text.length == 0) {
        [self.view makeToast:@"请输入提币地址" duration:2 position:CSToastPositionCenter];

        return;
    }
    if (_numberText.text.length == 0) {
           [self.view makeToast:@"请输入提币数量" duration:2 position:CSToastPositionCenter];

           return;
       }
    if (_pwText.text.length == 0) {
           [self.view makeToast:@"请输入交易密码" duration:2 position:CSToastPositionCenter];

           return;
       }
    
//    [LYNetwork POSTWithApiPath:coinWithdraw requestParams:@{
//             @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",@"withdrawDTO":@{@"address":self.assModel.userAddress,@"coinType":self.assModel.coinType,@"amount":self.numberText.text,@"transPassword":self.pwText.text},
//         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
//
//        NSLog(@"成功");
//        [self.view makeToast:@"提币成功" duration:2 position:CSToastPositionCenter];
//         self.submitBtn.enabled = NO;
//
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
    
    
    
    self.submitBtn.enabled = NO;
    [LYNetwork POSTWithApiPath:coinWithdraw requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",@"withdrawDTO":@{@"address":self.addressText.text,@"coinType":self.assModel.coinType,@"amount":self.numberText.text,@"transPassword":self.pwText.text},
    } shouldHandlerError:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        self.submitBtn.enabled = YES;
        if (error) {
            [self.view makeToast:@"提币失败" duration:2 position:CSToastPositionCenter];

        }
        else
        {
            
            if ([[response objectForKey:@"code"] integerValue]!= 0) {
                [self.view makeToast:[response objectForKey:@"message"] duration:2 position:CSToastPositionCenter];
            }
            else
            {
                NSLog(@"成功");
                [self.view makeToast:@"提币成功" duration:2 position:CSToastPositionCenter];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
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
