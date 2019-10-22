// LYLoginPwdViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYLoginPwdViewController.h"
#import "UIColor+Extention.h"
@interface LYLoginPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdAgainTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LYLoginPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTextFieldPlaceholder];
    
    self.navigationItem.title = @"登录密码";
    
    [self.commitBtn ly_gradint];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark🐒------提交------🐒
- (IBAction)comitAction:(UIButton *)sender {
}


- (void) configTextFieldPlaceholder{
    self.oldPwdTF.attributedPlaceholder = [self.oldPwdTF.placeholder ly_attributePlaceholder];
    self.pwdTF.attributedPlaceholder = [self.pwdTF.placeholder ly_attributePlaceholder];
    self.pwdAgainTF.attributedPlaceholder = [self.pwdAgainTF.placeholder ly_attributePlaceholder];
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
