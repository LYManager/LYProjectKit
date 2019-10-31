// LYLoginPwdViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYLoginPwdViewController.h"
#import "UIColor+Extention.h"
#import "UIButton+Timer.h"

@interface LYLoginPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;//yanzhengma
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdAgainTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation LYLoginPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTextFieldPlaceholder];
    
    self.navigationItem.title = self.myTag;
    
    [self.commitBtn ly_gradint];
    // Do any additional setup after loading the view from its nib.
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.oldPwdTF.keyboardType = UIKeyboardTypeNumberPad;

    if ([self.myTag isEqualToString:@"交易密码"]) {
        self.pwdTF.keyboardType = UIKeyboardTypeNumberPad;
        self.pwdAgainTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    self.pwdTF.secureTextEntry = YES;
    self.pwdAgainTF.secureTextEntry = YES;
    
}
#pragma mark🐒------提交------🐒
- (IBAction)comitAction:(UIButton *)sender {
    if ([self.myTag isEqualToString:@"登录密码"])
    {
        //登录密码
        if (self.phoneText.text.length !=11)
        {
            [self.view makeToast:@"手机号输入不正确" duration:2 position:CSToastPositionCenter];
            return;
        }
        if (self.pwdTF.text.length < 6)
        {
            [self.view makeToast:@"登录密码至少为六位" duration:2 position:CSToastPositionCenter];
            return;
        }
        if (![self.pwdTF.text isEqualToString:self.pwdAgainTF.text])
        {
            [self.view makeToast:@"两次密码不一致" duration:2 position:CSToastPositionCenter];
            return;
        }
        [LYNetwork POSTWithApiPath:resetLogURL requestParams:@{
               @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",
               @"loginDTO":@{@"mobile":self.phoneText.text,@"newPassword":self.pwdTF.text,@"mobileCode":self.oldPwdTF.text},
           } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
            
            [self.view makeToast:@"修改成功" duration:1 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];

            });


        }];
    }
    else
    {
       

        //登录密码
               if (self.phoneText.text.length !=11)
               {
                   [self.view makeToast:@"手机号输入不正确" duration:2 position:CSToastPositionCenter];
                   return;
               }
               if (self.pwdTF.text.length != 6)
               {
                   [self.view makeToast:@"支付密码只能为六位数字" duration:2 position:CSToastPositionCenter];
                   return;
               }
               if (![self.pwdTF.text isEqualToString:self.pwdAgainTF.text])
               {
                   [self.view makeToast:@"两次密码不一致" duration:2 position:CSToastPositionCenter];
                   return;
               }
               [LYNetwork POSTWithApiPath:resetZhiURL requestParams:@{
                      @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",
                      @"loginDTO":@{@"mobile":self.phoneText.text,@"newPassword":self.pwdTF.text,@"mobileCode":self.oldPwdTF.text},
                  } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
                   
                     [self.view makeToast:@"修改成功" duration:1 position:CSToastPositionCenter];
                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         [self.navigationController popViewControllerAnimated:YES];

                     });

               }];
    }
    
    
    
    
}
//发送验证码
- (IBAction)sendAction:(UIButton *)sender {
   
    if (self.phoneText.text.length !=11)
    {
        [self.view makeToast:@"手机号输入不正确" duration:2 position:CSToastPositionCenter];
        return;
    }
    [LYNetwork POSTWithApiPath:sendCodeURL requestParams:@{
        @"loginDTO":@{@"mobile":self.phoneText.text},
       } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        sender.time = 60;
        sender.format = @"%ld秒后重试";
        [sender startTimer];
    }];
    
}

- (void) configTextFieldPlaceholder{
    self.oldPwdTF.attributedPlaceholder = [self.oldPwdTF.placeholder ly_attributePlaceholder];
    self.pwdTF.attributedPlaceholder = [self.pwdTF.placeholder ly_attributePlaceholder];
    self.pwdAgainTF.attributedPlaceholder = [self.pwdAgainTF.placeholder ly_attributePlaceholder];
    self.phoneText.attributedPlaceholder = [self.phoneText.placeholder ly_attributePlaceholder];

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
