// LYPayPopViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/20. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYPayPopViewController.h"
#import "LYPayPwdViewManager.h"
#import "LYPopContentView.h"
@interface LYPayPopViewController ()<SWOAuthCodeViewDelegate>
@property (weak, nonatomic) IBOutlet LYPopContentView *contentView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LYPayPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configPwdView];
    
    // Do any additional setup after loading the view from its nib.
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
