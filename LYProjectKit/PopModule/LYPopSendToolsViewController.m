// LYPopSendToolsViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYPopSendToolsViewController.h"
#import "LYPopContentView.h"
#import "LYPayPwdViewManager.h"
#import "LYSureSendCardView.h"
@interface LYPopSendToolsViewController ()<SWOAuthCodeViewDelegate,LYSureSendCardViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet LYPopContentView *contentView;
/**< 确定view*/
@property(nonatomic,strong)LYSureSendCardView * sureContentView;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextField *userIdTF;
@property (weak, nonatomic) IBOutlet UITextField *countTF;

@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
/**< <#des#>*/
@property(nonatomic,strong)NSString * pwd;
@end

@implementation LYPopSendToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configPwdView];
    self.userIdTF.attributedPlaceholder = [self.userIdTF.placeholder ly_attributePlaceholder];
     self.countTF.attributedPlaceholder = [self.countTF.placeholder ly_attributePlaceholder];
    [self configData];
    // Do any additional setup after loading the view from its nib.
}
- (void) configPwdView{
    SWOAuthCodeView * payView = [LYPayPwdViewManager p_getAuthCodeViewTarget:self beginEdit:NO];
    [self.pwdView addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

- (void) configData{
    self.cardNameLabel.text = self.cardModel.cardName;
}
- (IBAction)commitBtnAction:(UIButton *)sender {
    
    if (self.userIdTF.text.length == 0) {
        [self.view makeToast:@"请输入赠送ID" duration:1 position:CSToastPositionCenter];
        return;
    }

    if (self.countTF.text.length == 0) {
       [self.view makeToast:@"请输入赠送数量" duration:1 position:CSToastPositionCenter];
       return;
    }

    if (self.pwd.length != 6) {
        [self.view makeToast:@"请输入六位数支付密码" duration:1 position:CSToastPositionCenter];
        return;
    }
    __weak typeof(self)weakSelf = self;
    [LYNetwork POSTWithApiPath:confirmSendURL requestParams:@{@"toUserId":self.userIdTF.text} handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!error) {
            [strongSelf flipCnfirmPage:response[@"data"]];
        }
    }];
    
    
}

- (void)flipCnfirmPage:(NSDictionary *)dict{
    NSMutableDictionary * mutableDict = dict.mutableCopy;
    [mutableDict setObject:self.userIdTF.text forKey:@"userId"];
    [mutableDict setObject:self.countTF.text forKey:@"num"];
    [self.sureContentView configDataWithCardName:self.cardModel.cardName dataDict:mutableDict];
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.alpha = 0;
        self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        [UIView transitionWithView:self.contentView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.view addSubview:self.sureContentView];
            self.sureContentView.alpha = 1;
            self.sureContentView.transform = CGAffineTransformScale(self.sureContentView.transform, 1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)commitActionSender:(UIButton *)sender type:(LYSureSendCardViewAction)actionType{
    
    if (actionType == LYSureSendCardViewAction_Cancel) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        __weak typeof(self)weakSelf = self;
           [LYNetwork POSTWithApiPath:sendCardURL requestParams:@{
               @"keyWords":self.pwd,
               @"cardId":@(self.cardModel.cardId),
               @"toUserId":self.userIdTF.text,
               @"count":@([self.countTF.text integerValue])
           } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
                __strong typeof(weakSelf)strongSelf = weakSelf;
               [strongSelf.view makeToast:@"赠送成功" duration:1 position:CSToastPositionCenter];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   if (!error) {
                       !strongSelf.backBlock ? : strongSelf.backBlock();
                   }
                   [strongSelf dismissViewControllerAnimated:YES completion:nil];
               });
           }];
    }
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

- (void)oauthCodeView:(SWOAuthCodeView *)mqView didInputFinish:(NSString *)finalText{
    self.pwd = finalText;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.commitBtn ly_gradint];
}

#pragma mark🐒----- lazy------🐒
- (LYSureSendCardView *)sureContentView{
    if (!_sureContentView) {
        _sureContentView  = [[NSBundle mainBundle]loadNibNamed:@"LYSureSendCardView" owner:self options:nil][0];
        _sureContentView.frame = CGRectMake(50, 120, [UIScreen mainScreen].bounds.size.width - 100, 300);
        _sureContentView.alpha = 0;
        _sureContentView.delegate = self;
    }
    return _sureContentView;
}

- (void)dealloc{
    
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
