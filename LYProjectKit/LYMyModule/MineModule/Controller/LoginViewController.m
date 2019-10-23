//
//  LoginViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LoginViewController.h"
#import "LYPageContext.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.accountNumberTF.attributedPlaceholder = [self.accountNumberTF.placeholder ly_attributePlaceholder];
    self.pwdTF.attributedPlaceholder = [self.pwdTF.placeholder ly_attributePlaceholder];
#if DEBUG
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
#endif
}

- (void) tapAction:(UITapGestureRecognizer *)tap{
    self.pwdTF.text = @"123456";
    self.accountNumberTF.text = @"333333";
}

- (IBAction)loginBtnAction:(UIButton *)sender {
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
