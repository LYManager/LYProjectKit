//
//  LoginViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LoginViewController.h"
#import "LYPageContext.h"
#import "LYLoginPwdViewController.h"
#import "RegisteredViewController.h"
#import "UIButton+Timer.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UILabel *pwBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *eyeImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *pwLab;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (nonatomic,strong)NSString *myTag;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myTag = @"1";
    
    self.accountNumberTF.attributedPlaceholder = [self.accountNumberTF.placeholder ly_attributePlaceholder];
    self.pwdTF.attributedPlaceholder = [self.pwdTF.placeholder ly_attributePlaceholder];
#if DEBUG
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
#endif
    
    UITapGestureRecognizer *codeGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeClick)];
    [self.codeBtn addGestureRecognizer:codeGestureRecognizer];

    self.codeBtn .userInteractionEnabled = YES;
    
     UITapGestureRecognizer *pwBtnGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pwBtnClick)];
    [self.pwBtn addGestureRecognizer:pwBtnGestureRecognizer];

    self.pwBtn .userInteractionEnabled = YES;
    self.pwBtn.layer.cornerRadius = 3;
    self.codeBtn.layer.cornerRadius = 3;
    self.pwBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.masksToBounds = YES;

    
}
-(void)pwBtnClick
{
    self.myTag = @"1";
    self.phoneLab.text = @"账号";
    self.pwLab.text = @"密码";
    self.eyeImage.hidden = NO;
    self.sendBtn.hidden = YES;
    self.pwdTF.placeholder = @"请输入密码";
    self.pwdTF.attributedPlaceholder = [self.pwdTF.placeholder ly_attributePlaceholder];
    self.pwBtn.backgroundColor = RGB(87, 187, 175, 1.0);
    self.codeBtn.backgroundColor = [UIColor clearColor];


}
-(void)codeClick
{
    self.myTag = @"2";
    self.phoneLab.text = @"手机号";
    self.pwLab.text = @"验证码";
    self.eyeImage.hidden = YES;
    self.sendBtn.hidden = NO;
    self.pwdTF.placeholder = @"请输入验证码";
    self.pwdTF.attributedPlaceholder = [self.pwdTF.placeholder ly_attributePlaceholder];
    self.codeBtn.backgroundColor = RGB(87, 187, 175, 1.0);
    self.pwBtn.backgroundColor = [UIColor clearColor];
    

}
- (void) tapAction:(UITapGestureRecognizer *)tap{
    self.pwdTF.text = @"123456";
    self.accountNumberTF.text = @"333333";
}
- (IBAction)sendAction:(UIButton *)sender {

    if (self.accountNumberTF.text.length !=11)
       {
           [self.view makeToast:@"手机号输入不正确" duration:2 position:CSToastPositionCenter];
           return;
           
       }
       
       [LYNetwork POSTWithApiPath:sendCodeURL requestParams:@{
              @"loginDTO":@{@"mobile":self.accountNumberTF.text},
             } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
              sender.time = 60;
              sender.format = @"%ld秒后重试";
              [sender startTimer];
          }];
}

- (IBAction)loginBtnAction:(UIButton *)sender {
    
    if ([self.myTag isEqualToString:@"1"]) {
          if (self.pwdTF.text.length == 0 || self.accountNumberTF.text.length == 0) {
                [self.view makeToast:@"请填写正确信息" duration:1 position:CSToastPositionCenter];
                return;
            }
            
            [LYNetwork POSTWithApiPath:loginURL requestParams:@{
                @"loginDTO":@{
                        @"mobile":self.accountNumberTF.text,
                        @"password":self.pwdTF.text
                }
            } handler:^(NSDictionary * _Nonnull response, NSError * _Nullable error) {
                if (!error) {
                    [LYUserDefault shareInstance].userInfoDict = response;
        //            登录成功
                    LYUserInfo *info =  [LYUserInfo modelWithJSON:response[@"data"]];
                    [LYUserInfoManager shareInstance].userInfo = info;
                    [[LYPageContext shareInstance]setupMainViewController];
                }
            }];
    }
    else
    {
        if (self.accountNumberTF.text.length != 11) {
            [self.view makeToast:@"请填写正确手机号" duration:1 position:CSToastPositionCenter];
            return;
        }
        if (self.pwdTF.text.length < 0) {
            [self.view makeToast:@"验证码输入有误" duration:1 position:CSToastPositionCenter];
            return;
        }
        
        [LYNetwork POSTWithApiPath:codelogURL requestParams:@{
                @"loginDTO":@{
                        @"mobile":self.accountNumberTF.text,
                        @"mobileCode":self.pwdTF.text
                }
            } handler:^(NSDictionary * _Nonnull response, NSError * _Nullable error) {
                if (!error) {
                    [LYUserDefault shareInstance].userInfoDict = response;
        //            登录成功
                    LYUserInfo *info =  [LYUserInfo modelWithJSON:response[@"data"]];
                    [LYUserInfoManager shareInstance].userInfo = info;
                    [[LYPageContext shareInstance]setupMainViewController];
                }
            }];
    }
  
}
- (IBAction)forgetBtnAction:(id)sender {
    LYLoginPwdViewController *logVC = [[LYLoginPwdViewController alloc]init];
    logVC.myTag =  @"登录密码";
    [self.navigationController pushViewController:logVC animated:YES];}

- (IBAction)registAction:(id)sender {
    RegisteredViewController *regVC = [[RegisteredViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
    
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
