// LYPopToolsViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYPopToolsViewController.h"
#import "LYPayPwdViewManager.h"
#import "LYPopContentView.h"
@interface LYPopToolsViewController ()<SWOAuthCodeViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet LYPopContentView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
/**< pwd*/
@property(nonatomic,copy)NSString *  pwd;
@end

@implementation LYPopToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configPwdView];
    
    [self configData];
    // Do any additional setup after loading the view from its nib.
}

/// 只能使用工会卡
/// @param sender sender
- (IBAction)useToolsAction:(UIButton *)sender {
    if (self.pwd.length != 6) {
        [self.view makeToast:@"请输入六位支付密码" duration:2 position:CSToastPositionCenter];
        return;
    }
//    认证卡回调回去
    if (self.callBack) {
        self.callBack(self.pwd);
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [LYNetwork POSTWithApiPath:useCardURL requestParams:@{
        @"keyWords":self.pwd
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"使用成功" duration:2 position:CSToastPositionCenter];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)oauthCodeView:(SWOAuthCodeView *)mqView didInputFinish:(NSString *)finalText{
    self.pwd = finalText;
}

- (void) configData{
    self.cardNameLabel.text = self.cardModel.cardName;
    self.bottomLabel.text = self.cardModel.cardId == 1 ? @"使用后即可进行实名认证" : @"使用后即可加入蚂蚁工会";
}

- (void) configPwdView{
    SWOAuthCodeView * payView = [LYPayPwdViewManager p_getAuthCodeViewTarget:self beginEdit:YES];
    [self.pwdView addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:NO completion:nil];
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
