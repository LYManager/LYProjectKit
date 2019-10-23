// LYPayPopViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/20. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYPayPopViewController.h"
#import "LYPayPwdViewManager.h"
#import "LYPopContentView.h"
@interface LYPayPopViewController ()<SWOAuthCodeViewDelegate>
@property (weak, nonatomic) IBOutlet LYPopContentView *contentView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/**< pwd*/
@property(nonatomic,copy)NSString *  pwd;
@end

@implementation LYPayPopViewController
// 8665462
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configPwdView];
    
    [self configData];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)commitBtnAction:(UIButton *)sender {
    if (self.pwd.length != 6) {
        [self.view makeToast:@"请输入六位支付密码" duration:2 position:CSToastPositionCenter];
        return;
    }
    [LYNetwork POSTWithApiPath:payTaskURL requestParams:@{
        @"keyWords":self.pwd,
        @"taskId":@(self.model.taskId)
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [self.view makeToast:@"购买成功" duration:2 position:CSToastPositionCenter];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (void)oauthCodeView:(SWOAuthCodeView *)mqView didInputFinish:(NSString *)finalText{
    self.pwd = finalText;
}

- (void) configData{
    self.cardNameLabel.text = self.model.taskName;
    self.cycleTimeLabel.text = [NSString stringWithFormat:@"周期 : %ld天",self.model.cycleDays];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2ldAGC",self.model.amount];
}

- (void) configPwdView{
    SWOAuthCodeView * oacView = [LYPayPwdViewManager p_getAuthCodeViewTarget:self beginEdit:YES];
    [self.pwdView addSubview:oacView];
    //创建view时，需要指定验证码的长度
    [oacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=0.1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:0.6];
    theAnimation.toValue = [NSNumber numberWithFloat:1];
     [self.contentView.layer addAnimation:theAnimation forKey:@"animateTransform"];
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
      [self.commitBtn ly_gradint];
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
