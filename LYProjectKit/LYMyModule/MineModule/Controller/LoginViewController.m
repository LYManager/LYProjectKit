//
//  LoginViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 赵良育. All rights reserved.
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
}

- (IBAction)loginBtnAction:(UIButton *)sender {
    [LYNetwork POSTWithApiPath:loginURL requestParams:@{
        @"loginDTO":@{
                @"mobile":@"333333",
                @"password":@"123456"
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
