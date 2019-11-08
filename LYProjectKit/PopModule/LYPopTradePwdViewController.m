// LYPopTradePwdViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/7. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYPopTradePwdViewController.h"
#import "LYPayPwdViewManager.h"
@interface LYPopTradePwdViewController ()<SWOAuthCodeViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fabuTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;
@property (weak, nonatomic) IBOutlet UIView *pwdView;


@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property(nonatomic,copy)NSString *  pwd;
/**< <#des#>*/
@property(nonatomic,assign)TradePopType type;
/**< <#des#>*/
@property(nonatomic,copy)TradeCallBack  callBack;

@property (weak, nonatomic) IBOutlet UILabel *agcLabel;
@property (weak, nonatomic) IBOutlet UILabel *cnyLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

/**< <#des#>*/
@property(nonatomic,copy)NSString *  agc;
/**< des*/
@property(nonatomic,copy)NSString *  cny;
@end

@implementation LYPopTradePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [self configPwdView];
    // Do any additional setup after loading the view from its nib.
}

- (void) configDataWithType:(TradePopType)type
                        AGC:(NSString *)agcAmount
                        CNY:(NSString *)cnyAmount
                   callBack:(TradeCallBack)tradeCallBack{
    self.type = type;
    self.callBack = tradeCallBack;
    self.agc = agcAmount;
    self.cny = cnyAmount;
}

- (void) configUI {
    NSString * title;
    NSString * leftTopTitle;
    NSString * leftBottomTitle;
    BOOL hiddenDesLabel;
    switch (self.type) {
        case TradePopType_Buy:
        {
            title = @"发布买单";
            leftTopTitle = @"买入";
            leftBottomTitle = @"总价";
            hiddenDesLabel = YES;
        }
        break;
        case TradePopType_Sale:
        {
            title = @"确认出售";
            leftTopTitle = @"卖出";
            leftBottomTitle = @"总价";
            hiddenDesLabel = YES;
        }
        break;
        case TradePopType_Bind:
       {
           title = @"确认绑定";
//           leftTopTitle = @"卖出";
//           leftBottomTitle = @"总价";
           hiddenDesLabel = NO;
       }
       break;
    }
    self.desLabel.hidden = hiddenDesLabel;
    self.leftTopLabel.text = leftTopTitle;
    self.leftBottomLabel.text = leftBottomTitle;
    self.fabuTitleLabel.text = title;
    self.agcLabel.text = self.agc;
    self.cnyLabel.text = self.cny;
}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmBtnAction:(id)sender {
    !self.callBack ? : self.callBack(self.pwd);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)oauthCodeView:(SWOAuthCodeView *)mqView didInputFinish:(NSString *)finalText{
    self.pwd = finalText;
}
- (void) configPwdView{
    SWOAuthCodeView * payView = [LYPayPwdViewManager p_getAuthCodeViewTarget:self beginEdit:YES];
    [self.pwdView addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.confirmBtn ly_gradint];
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
