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
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (nonatomic,strong)NSString *myTag;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *registStr = @"没有账号？立即注册";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",registStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,7)];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:13/255.0 green:194/255.0 blue:167/255.0 alpha:1.0] range:NSMakeRange(7,2)];
    [self.registBtn setAttributedTitle:str forState:UIControlStateNormal];
        
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backImage"]]];


    
    
    self.myTag = @"1";
    
    self.accountNumberTF.attributedPlaceholder = [self attributePlaceholder:self.accountNumberTF.placeholder];
    self.pwdTF.attributedPlaceholder = [self attributePlaceholder:self.pwdTF.placeholder];
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
    self.pwdTF.secureTextEntry = YES;
    

    
    //密码显示
    UITapGestureRecognizer *imageGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    [self.eyeImage addGestureRecognizer:imageGestureRecognizer];
    self.eyeImage.userInteractionEnabled = YES;
    
}
-(void)pwBtnClick
{
    self.myTag = @"1";
    self.phoneLab.text = @"账号";
    self.pwLab.text = @"密码";
    self.eyeImage.hidden = NO;
    self.sendBtn.hidden = YES;
    self.pwdTF.placeholder = @"请输入密码";
    self.pwdTF.attributedPlaceholder = [self attributePlaceholder:self.pwdTF.placeholder];
//    self.pwBtn.backgroundColor = RGB(87, 187, 175, 1.0);
//    self.codeBtn.backgroundColor = [UIColor clearColor];
    self.pwdTF.secureTextEntry = YES;
    self.pwdTF.text = @"";

    self.pwBtn.text = @"• 密码登录";
    self.codeBtn.text = @"验证码登录";
    

}
-(void)codeClick
{
    self.myTag = @"2";
    self.phoneLab.text = @"手机号";
    self.pwLab.text = @"验证码";
    self.eyeImage.hidden = YES;
    self.sendBtn.hidden = NO;
    self.pwdTF.placeholder = @"请输入验证码";
    self.pwdTF.attributedPlaceholder = [self attributePlaceholder:self.pwdTF.placeholder];
//    self.codeBtn.backgroundColor = RGB(87, 187, 175, 1.0);
//    self.pwBtn.backgroundColor = [UIColor clearColor];
    self.pwdTF.secureTextEntry = NO;
    self.pwdTF.text = @"";
    self.pwBtn.text = @"密码登录";
    self.codeBtn.text = @"• 验证码登录";

}
-(void)imageClick
{
    NSString *imageStr = self.pwdTF.secureTextEntry?@"e2":@"e1";
    self.eyeImage.image = [UIImage imageNamed:imageStr];
    self.pwdTF.secureTextEntry = !self.pwdTF.secureTextEntry;
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


- (NSMutableAttributedString *)attributePlaceholder:(NSString *)str{
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:119/255.0 green:121/255.0 blue:156/255.0 alpha:1.0]} range:NSMakeRange(0, str.length)];
    return attr;
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
