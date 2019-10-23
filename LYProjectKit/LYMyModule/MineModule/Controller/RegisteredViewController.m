//
//  RegisteredViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/19.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "RegisteredViewController.h"
#import "UIColor+Extention.h"
#import "UIButton+Timer.h"
#import "LYPageContext.h"
@interface RegisteredViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneLab;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UITextField *pwText;
@property (weak, nonatomic) IBOutlet UITextField *pwAgainText;
@property (weak, nonatomic) IBOutlet UITextField *invitText;
@property (weak, nonatomic) IBOutlet UITextField *moneyPwText;
@property (weak, nonatomic) IBOutlet UIImageView *eyeImage;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;

@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"账号注册";
    
    
    [self configTextFieldPlaceholder];
    [self.regBtn ly_gradint];
    self.phoneLab.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.moneyPwText.keyboardType = UIKeyboardTypeNumberPad;
    

    
}
- (IBAction)sendAction:(UIButton *)sender {
    
    if (self.phoneLab.text.length !=11)
    {
        [self.view makeToast:@"手机号输入不正确" duration:2 position:CSToastPositionCenter];
        return;
        
    }
    
    [LYNetwork POSTWithApiPath:sendCodeURL requestParams:@{
           @"loginDTO":@{@"mobile":self.phoneLab.text},
          } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
           sender.time = 60;
           sender.format = @"%ld秒后重试";
           [sender startTimer];
       }];
}

- (IBAction)registBtn:(id)sender {
    if (self.phoneLab.text.length !=11)
       {
           [self.view makeToast:@"手机号输入不正确" duration:2 position:CSToastPositionCenter];
           return;
       }
    if (self.codeText.text.length !=6)
    {
        [self.view makeToast:@"验证码输入不正确" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.pwText.text.length <6)
    {
        [self.view makeToast:@"密码不能小于六位" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (![self.pwText.text isEqualToString:self.pwAgainText.text])
    {
        [self.view makeToast:@"两次输入密码不一致" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.invitText.text.length == 0)
       {
           [self.view makeToast:@"邀请码不能为空" duration:2 position:CSToastPositionCenter];
           return;
       }
    if (self.moneyPwText.text.length !=6)
    {
        [self.view makeToast:@"交易密码只能为六位数字" duration:2 position:CSToastPositionCenter];
        return;
    }
    
    [LYNetwork POSTWithApiPath:registURL requestParams:@{@"loginDTO":@{@"mobile":self.phoneLab.text,@"password":self.pwText.text,@"mobileCode":self.codeText.text,@"inviteCode":self.invitText.text,@"transPassword":self.moneyPwText.text,},
       } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [[LYPageContext shareInstance]setupLoginViewController];

    }];
    
}


- (void) configTextFieldPlaceholder{
    self.phoneLab.attributedPlaceholder = [self.phoneLab.placeholder ly_attributePlaceholder];
    self.codeText.attributedPlaceholder = [self.codeText.placeholder ly_attributePlaceholder];
    self.pwText.attributedPlaceholder = [self.pwText.placeholder ly_attributePlaceholder];
    self.pwAgainText.attributedPlaceholder = [self.pwAgainText.placeholder ly_attributePlaceholder];
    self.invitText.attributedPlaceholder = [self.invitText.placeholder ly_attributePlaceholder];
    self.moneyPwText.attributedPlaceholder = [self.moneyPwText.placeholder ly_attributePlaceholder];
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
